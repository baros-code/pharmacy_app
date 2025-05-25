import '../../../../../core/utils/result.dart';
import '../../../../../core/utils/use_case.dart';

import '../entities/prescription.dart';
import '../repositories/pharmacy_repository.dart';

class FetchPrescriptions extends UseCase<String, List<Prescription>, void> {
  FetchPrescriptions(this._pharmacyRepository, super.logger);

  final PharmacyRepository _pharmacyRepository;

  @override
  Future<Result<List<Prescription>, Failure>> call({String? params}) {
    return _pharmacyRepository.fetchPrescriptions(params!);
  }
}
