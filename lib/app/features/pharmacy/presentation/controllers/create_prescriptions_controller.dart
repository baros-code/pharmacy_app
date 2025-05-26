import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/presentation/controller.dart';
import '../../../../shared/utils/app_router.dart';
import '../../../../shared/utils/custom_image_picker.dart';
import '../../../../shared/utils/permission_manager.dart';
import '../../../../shared/widgets/selection_popup.dart';
import '../../../../shared/widgets/selection_view.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../domain/entities/medication.dart';
import '../cubit/pharmacy_cubit.dart';

// TODO(Baran): The attachments consist of local file paths,
// but they should be uploaded to Firestore.
class CreatePrescriptionsController extends Controller<Object> {
  CreatePrescriptionsController(
    super.logger,
    super.popupManager,
    this._imagePicker,
    this._permissionManager,
  );

  final CustomImagePicker _imagePicker;
  final PermissionManager _permissionManager;

  late AuthCubit _authCubit;
  late PharmacyCubit _pharmacyCubit;

  List<Medication> get medications => _pharmacyCubit.medications;

  List<Medication> selectedMedications = [];
  String? additionalNotes;
  DateTime? issueDate;
  List<String> selectedAttachments = [];

  @override
  void onStart() {
    super.onStart();
    _pharmacyCubit =
        context.read<PharmacyCubit>()..stream.listen(_handleStates);
    _authCubit = context.read<AuthCubit>();
  }

  void _handleStates(PharmacyState state) {
    if (state is PrescriptionCreationFailure) {
      popupManager.showToastMessage(
        context,
        'Failed to create prescription, please try again.',
      );
    } else if (state is PrescriptionCreated) {
      if (context.mounted) {
        context.goNamed(RouteConfig.prescriptionsRoute.name);
        popupManager.showToastMessage(
          context,
          'Prescription created successfully!',
        );
      }
    }
  }

  void openMedicationSelectionView() {
    popupManager.showFullScreenPopup(
      context,
      SelectionPopup(
        items: _createFilterItems(medications),
        title: 'Select medications for your prescription',
        searchBarHintText: 'Search medications by name',
        selectionText: 'selected medications',
        onSelectionResult: (items) {
          selectedMedications = items;
          _pharmacyCubit.medicationsSelected(selectedMedications);
        },
      ),
    );
  }

  Future<void> openIssueDatePicker() async {
    final pickedDate = await popupManager.showCustomDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      issueDate = pickedDate;
      _pharmacyCubit.issueDateSelected(issueDate!);
    }
  }

  void setAdditionalNotes(String notes) {
    additionalNotes = notes;
  }

  Future<void> openAttachmentsPicker() async {
    if (kIsWeb) {
      // TODO(Baran): Handle web attachments with filepicker package in future.
      popupManager.showToastMessage(
        context,
        'For now you can only attach images or photos on mobile devices.',
      );
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return _ImagePickerDialog(
          onCamera: () => _pickImage(PermissionType.camera),
          onGallery: () => _pickImage(PermissionType.storageRead),
          onSelectionComplete:
              () => _pharmacyCubit.attachmentsSelected(selectedAttachments),
        );
      },
    );
  }

  void createPrescription() {
    if (selectedMedications.isEmpty || issueDate == null) {
      popupManager.showToastMessage(
        context,
        'Please fill in the required fields before proceeding.',
      );
      return;
    }
    _pharmacyCubit.createPrescription(
      patientId: _authCubit.userCache!.id,
      medicationIds: selectedMedications.map((e) => e.id).toList(),
      instructions: additionalNotes ?? '',
      issueDate: issueDate!,
      attachments: selectedAttachments,
    );
  }

  // Helpers
  List<FilterItem<Medication>> _createFilterItems(
    List<Medication> medications,
  ) {
    return medications
        .map(
          (medication) => FilterItem<Medication>(
            filterObject: medication,
            widget: Text(
              medication.fullLabel,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.black),
            ),
            searchTexts: [medication.name],
            isSelected: selectedMedications.contains(medication),
          ),
        )
        .toList();
  }

  Future<void> _pickImage(PermissionType type) async {
    if (type == PermissionType.camera) {
      final permission = await _permissionManager.checkPermission(type);
      if (permission.state.isGranted) {
        await _getImage(type);
      } else {
        if (context.mounted && !permission.isFirstPermanentlyDenied) {
          _showPermissionRequiredDialog(type);
        }
      }
    } else {
      await _getImage(type);
    }
  }

  Future<void> _getImage(PermissionType type) async {
    final result =
        type == PermissionType.storageRead
            ? await _imagePicker.pickMultipleImages()
            : await _imagePicker.takePhoto();
    if (result.isSuccessful) {
      if (result.value == null) {
        return;
      }
      selectedAttachments.clear();
      result.value is List<String>
          ? selectedAttachments.addAll(result.value as List<String>)
          : selectedAttachments.add(result.value as String);
    } else {
      if (context.mounted) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error occurred while selecting image'),
              content: Text(result.error?.message ?? 'Unknown error'),
            );
          },
        );
      }
    }
  }

  Future<void> _showPermissionRequiredDialog(PermissionType type) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Permission required'),
          content: Text(type.dialogText),
          actions: [
            TextButton(
              onPressed: _permissionManager.openAppPermissionSettings,
              child: Text('Open settings'),
            ),
          ],
        );
      },
    );
  }

  // - Helpers
}

class _ImagePickerDialog extends StatelessWidget {
  const _ImagePickerDialog({
    required this.onGallery,
    required this.onCamera,
    this.onSelectionComplete,
  });

  final Future<void> Function() onGallery;
  final Future<void> Function() onCamera;
  final VoidCallback? onSelectionComplete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose images or photos'),
      content: const Text(
        'You can attach images or photos to your prescription. '
        'This is optional and can be done later.',
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Choose from gallery'),
          onPressed: () async {
            Navigator.of(context).pop();
            await onGallery();
            onSelectionComplete?.call();
          },
        ),
        TextButton(
          child: const Text('Take photo'),
          onPressed: () async {
            Navigator.of(context).pop();
            await onCamera();
            onSelectionComplete?.call();
          },
        ),
      ],
    );
  }
}
