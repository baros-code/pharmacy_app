import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/utils/result.dart';

import '../../domain/use_cases/fetch_medications.dart';
import '../models/medication_model.dart';

abstract class PharmacyRemoteService {
  /// Fetches a list of medications from the remote service.
  Future<Result<List<MedicationModel>, Failure>> fetchMedications(
    FetchMedicationsParams params,
  );
}

class PharmacyRemoteServiceImpl implements PharmacyRemoteService {
  PharmacyRemoteServiceImpl();

  final dataSource = FirebaseFirestore.instance;

  @override
  Future<Result<List<MedicationModel>, Failure>> fetchMedications(
    FetchMedicationsParams params,
  ) async {
    try {
      final snapshot =
          params.name != null
              ? await FirebaseFirestore.instance
                  .collection('medications')
                  .orderBy('name')
                  .startAt([params.name!])
                  .endAt(['${params.name!}\uf8ff'])
                  .get()
              : await dataSource.collection('medications').get();
      final medications =
          snapshot.docs
              .map((doc) => MedicationModel.fromJson(doc.data()))
              .toList();
      return Result.success(value: medications);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }
}
