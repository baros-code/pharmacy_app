part of 'pharmacy_cubit.dart';

sealed class PharmacyState {
  const PharmacyState();
}

class PharmacyInitial extends PharmacyState {}

class MedicationsLoading extends PharmacyState {}

class MedicationsFetched extends PharmacyState {
  const MedicationsFetched(this.medications);

  final List<Medication> medications;
}

class MedicationsFetchFailure extends PharmacyState {
  const MedicationsFetchFailure(this.error);

  final String error;
}

class MedicationsCategorySelected extends PharmacyState {
  const MedicationsCategorySelected(this.category);

  final String category;
}

class PrescriptionsLoading extends PharmacyState {}

class PrescriptionsFetched extends PharmacyState {
  const PrescriptionsFetched(this.prescriptions);

  final List<Prescription> prescriptions;
}

class PrescriptionsFetchFailure extends PharmacyState {
  const PrescriptionsFetchFailure(this.error);

  final String error;
}

class PrescriptionCreating extends PharmacyState {}

class PrescriptionCreated extends PharmacyState {}

class PrescriptionCreationFailure extends PharmacyState {
  const PrescriptionCreationFailure(this.error);

  final String error;
}

class MedicationsSelected extends PharmacyState {
  const MedicationsSelected(this.selectedMedications);

  final List<Medication> selectedMedications;
}

class IssueDateSelected extends PharmacyState {
  const IssueDateSelected(this.issueDate);

  final DateTime issueDate;
}

class AttachmentsSelected extends PharmacyState {
  const AttachmentsSelected(this.attachments);

  final List<String> attachments;
}
