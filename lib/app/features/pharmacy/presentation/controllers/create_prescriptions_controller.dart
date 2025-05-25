import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/presentation/controller.dart';
import '../../../../shared/widgets/selection_popup.dart';
import '../../../../shared/widgets/selection_view.dart';
import '../../domain/entities/medication.dart';
import '../cubit/pharmacy_cubit.dart';

class CreatePrescriptionsController extends Controller<Object> {
  CreatePrescriptionsController(super.logger, super.popupManager);

  late PharmacyCubit _pharmacyCubit;

  List<Medication> get medications => _pharmacyCubit.medications;

  List<Medication> selectedMedications = [];
  String? additionalNotes;
  DateTime? issueDate;

  @override
  void onStart() {
    super.onStart();
    _pharmacyCubit = context.read<PharmacyCubit>();
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

  void setAdditionalNotes(String notes) {
    additionalNotes = notes;
  }

  Future<void> openIssueDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      issueDate = pickedDate;
      _pharmacyCubit.issueDateSelected(issueDate!);
    }
  }

  void createPrescription() {
    if (selectedMedications.isEmpty || issueDate == null) {
      popupManager.showToastMessage(
        context,
        'Please fill in the required fields before proceeding.',
      );
      return;
    }
    // _pharmacyCubit.createPrescription(selectedMedications);
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
