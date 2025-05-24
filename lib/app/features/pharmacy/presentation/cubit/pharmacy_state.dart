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
