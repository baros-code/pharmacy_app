import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/medication.dart';
import '../../domain/use_cases/fetch_medications.dart';

part 'pharmacy_state.dart';

class PharmacyCubit extends Cubit<PharmacyState> {
  PharmacyCubit(this._fetchMedications) : super(PharmacyInitial());

  final FetchMedications _fetchMedications;

  List<Medication> medications = [];

  List<String> categories = [];

  bool isFirstFetch = true;

  Future<void> fetchMedications({String? name}) async {
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

  // Helpers
  void _setCategories() {
    categories =
        medications.map((medication) => medication.category).toSet().toList();
    // - Helpers
  }
}
