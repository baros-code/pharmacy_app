import '../../../../../core/utils/result.dart';
import '../entities/medication.dart';
import '../entities/prescription.dart';
import '../use_cases/create_prescription.dart';
import '../use_cases/fetch_medications.dart';

abstract class PharmacyRepository {
  /// Fetches a list of medications from the repository.
  Future<Result<List<Medication>, Failure>> fetchMedications(
    FetchMedicationsParams params,
  );

  /// Creates a prescription in the repository.
  Future<Result> createPrescription(CreatePrescriptionParams params);

  /// Fetches a list of prescriptions for a specific patient.
  Future<Result<List<Prescription>, Failure>> fetchPrescriptions(
    String patientId,
  );
}
