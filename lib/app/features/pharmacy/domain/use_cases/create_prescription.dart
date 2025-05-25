import '../../../../../core/utils/result.dart';
import '../../../../../core/utils/use_case.dart';
import '../repositories/pharmacy_repository.dart';

class CreatePrescription
    extends UseCase<CreatePrescriptionParams, Object, void> {
  CreatePrescription(this._pharmacyRepository, super.logger);

  final PharmacyRepository _pharmacyRepository;

  @override
  Future<Result> call({CreatePrescriptionParams? params}) {
    return _pharmacyRepository.createPrescription(params!);
  }
}

class CreatePrescriptionParams {
  const CreatePrescriptionParams({
    required this.patientId,
    required this.medicationIds,
    required this.issueDate,
    this.instructions,
    this.attachments,
  });

  final String patientId;
  final List<String> medicationIds;

  final DateTime issueDate;
  final String? instructions;
  final List<String>? attachments;

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'medicationIds': medicationIds,
      'instructions': instructions,
      'issueDate': issueDate.toIso8601String(),
      'attachments': attachments ?? [],
    };
  }
}
