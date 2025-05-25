import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/presentation/controller.dart';
import '../../../../shared/utils/app_router.dart';
import '../../../../shared/widgets/selection_popup.dart';
import '../../../../shared/widgets/selection_view.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../domain/entities/medication.dart';
import '../cubit/pharmacy_cubit.dart';

class CreatePrescriptionsController extends Controller<Object> {
  CreatePrescriptionsController(super.logger, super.popupManager);

  late AuthCubit _authCubit;
  late PharmacyCubit _pharmacyCubit;

  List<Medication> get medications => _pharmacyCubit.medications;

  List<Medication> selectedMedications = [];
  String? additionalNotes;
  DateTime? issueDate;

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

  void openAttachmentsPicker() {}

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

  // - Helpers
}
