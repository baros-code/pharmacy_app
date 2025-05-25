part of 'pharmacy_cubit.dart';

sealed class PharmacyState extends Equatable {
  const PharmacyState();

  @override
  List<Object> get props => [];
}

class PharmacyInitial extends PharmacyState {}

class MedicationsLoading extends PharmacyState {}

class MedicationsFetched extends PharmacyState {
  const MedicationsFetched(this.medications);

  final List<Medication> medications;

  @override
  List<Object> get props => [medications];
}

class MedicationsFetchFailure extends PharmacyState {
  const MedicationsFetchFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class PrescriptionsLoading extends PharmacyState {}

class PrescriptionsFetched extends PharmacyState {
  const PrescriptionsFetched(this.prescriptions);

  final List<Prescription> prescriptions;

  @override
  List<Object> get props => [prescriptions];
}

class PrescriptionsFetchFailure extends PharmacyState {
  const PrescriptionsFetchFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class PrescriptionCreating extends PharmacyState {}

class PrescriptionCreated extends PharmacyState {}

class PrescriptionCreationFailure extends PharmacyState {
  const PrescriptionCreationFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class MedicationsSelected extends PharmacyState {
  const MedicationsSelected(this.selectedMedications);

  final List<Medication> selectedMedications;

  @override
  List<Object> get props => [selectedMedications];
}

class IssueDateSelected extends PharmacyState {
  const IssueDateSelected(this.issueDate);

  final DateTime issueDate;

  @override
  List<Object> get props => [issueDate];
}

class AttachmentsSelected extends PharmacyState {
  const AttachmentsSelected(this.attachments);

  final List<String> attachments;

  @override
  List<Object> get props => [attachments];
}
