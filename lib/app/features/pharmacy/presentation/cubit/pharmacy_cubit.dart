import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/medication.dart';
import '../../domain/entities/prescription.dart';
import '../../domain/use_cases/create_prescription.dart';
import '../../domain/use_cases/fetch_medications.dart';
import '../../domain/use_cases/fetch_prescriptions.dart';

part 'pharmacy_state.dart';

class PharmacyCubit extends Cubit<PharmacyState> {
  PharmacyCubit(
    this._fetchMedications,
    this._createPrescription,
    this._fetchPrescriptions,
  ) : super(PharmacyInitial());

  final FetchMedications _fetchMedications;
  final CreatePrescription _createPrescription;
  final FetchPrescriptions _fetchPrescriptions;

  String? currentSearchQuery;
  String? selectedCategory;

  List<Medication> medications = [];
  List<String> categories = [];
  List<Prescription> prescriptions = [];

  bool isFirstFetch = true;

  Future<void> fetchMedications({String? name}) async {
    currentSearchQuery = name;
    emit(MedicationsLoading());
    final result = await _fetchMedications(
      params: FetchMedicationsParams(name: name),
    );
    if (result.isSuccessful) {
      medications = result.value!;
      if (isFirstFetch) {
        _setCategories();
      }
      emit(MedicationsFetched(result.value!));
      isFirstFetch = false;
      return;
    }
    emit(MedicationsFetchFailure(result.error!.message));
  }

  Future<void> fetchPrescriptions(String patientId) async {
    emit(PrescriptionsLoading());
    final result = await _fetchPrescriptions(params: patientId);
    if (result.isSuccessful) {
      prescriptions = result.value!;
      prescriptions.sort((a, b) => b.issueDate.compareTo(a.issueDate));
      emit(PrescriptionsFetched(prescriptions));
      return;
    }
    emit(PrescriptionsFetchFailure(result.error!.message));
  }

  Future<void> createPrescription({
    required String patientId,
    required List<String> medicationIds,
    required DateTime issueDate,
    String? instructions,
    List<String>? attachments,
  }) async {
    emit(PrescriptionCreating());
    final result = await _createPrescription(
      params: CreatePrescriptionParams(
        patientId: patientId,
        medicationIds: medicationIds,
        instructions: instructions,
        issueDate: issueDate,
        attachments: attachments,
      ),
    );
    if (result.isSuccessful) {
      emit(PrescriptionCreated());
      return;
    }
    emit(PrescriptionCreationFailure(result.error!.message));
  }

  void categorySelected(String? category) {
    selectedCategory = category;
  }

  void medicationsSelected(List<Medication> selectedMedications) {
    emit(MedicationsSelected(selectedMedications));
  }

  void issueDateSelected(DateTime issueDate) {
    emit(IssueDateSelected(issueDate));
  }

  void attachmentsSelected(List<String> attachments) {
    emit(AttachmentsSelected(attachments));
  }

  // Helpers
  void _setCategories() {
    categories =
        medications.map((medication) => medication.category).toSet().toList();
    // - Helpers
  }
}
