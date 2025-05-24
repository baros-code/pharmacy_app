import '../../../../../core/utils/result.dart';
import '../entities/medication.dart';
import '../use_cases/fetch_medications.dart';

abstract class PharmacyRepository {
  /// Fetches a list of medications from the repository.
  Future<Result<List<Medication>, Failure>> fetchMedications(
    FetchMedicationsParams params,
  );
}
