import '../../../../../core/utils/result.dart';
import '../../../../../core/utils/use_case.dart';
import '../entities/medication.dart';
import '../repositories/pharmacy_repository.dart';

class FetchMedications
    extends UseCase<FetchMedicationsParams, List<Medication>, void> {
  FetchMedications(this._pharmacyRepository, super.logger);

  final PharmacyRepository _pharmacyRepository;

  @override
  Future<Result<List<Medication>, Failure>> call({
    FetchMedicationsParams? params,
  }) {
    return _pharmacyRepository.fetchMedications(params!);
  }
}

class FetchMedicationsParams {
  const FetchMedicationsParams({this.name});

  final String? name;
}
