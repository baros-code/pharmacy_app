import '../../../../../core/utils/result.dart';
import '../../domain/entities/medication.dart';
import '../../domain/entities/prescription.dart';
import '../../domain/repositories/pharmacy_repository.dart';
import '../../domain/use_cases/create_prescription.dart';
import '../../domain/use_cases/fetch_medications.dart';
import '../services/pharmacy_remote_service.dart';

class PharmacyRepositoryImpl implements PharmacyRepository {
  PharmacyRepositoryImpl(this._remoteService);

  final PharmacyRemoteService _remoteService;

  @override
  Future<Result<List<Medication>, Failure>> fetchMedications(
    FetchMedicationsParams params,
  ) async {
    try {
      final result = await _remoteService.fetchMedications(params);
      if (result.isSuccessful) {
        return Result.success(
          value: result.value!.map((e) => e.toEntity()).toList(),
        );
      }
      return Result.failure(result.error);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<Result> createPrescription(CreatePrescriptionParams params) async {
    try {
      final result = await _remoteService.createPrescription(params);
      if (result.isSuccessful) {
        return Result.success();
      }
      return Result.failure(result.error);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<Prescription>, Failure>> fetchPrescriptions(
    String patientId,
  ) async {
    try {
      final result = await _remoteService.fetchPrescriptions(patientId);
      if (result.isSuccessful) {
        return Result.success(
          value: result.value!.map((e) => e.toEntity()).toList(),
        );
      }
      return Result.failure(result.error);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }
}
