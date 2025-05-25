import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/utils/result.dart';

import '../../domain/use_cases/create_prescription.dart';
import '../../domain/use_cases/fetch_medications.dart';
import '../models/medication_model.dart';
import '../models/prescription_model.dart';

abstract class PharmacyRemoteService {
  /// Fetches a list of medications from the remote service.
  Future<Result<List<MedicationModel>, Failure>> fetchMedications(
    FetchMedicationsParams params,
  );

  /// Creates a prescription in the remote service.
  Future<Result> createPrescription(CreatePrescriptionParams params);

  /// Fetches a list of prescriptions for a specific patient.
  Future<Result<List<PrescriptionModel>, Failure>> fetchPrescriptions(
    String patientId,
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

  @override
  Future<Result> createPrescription(CreatePrescriptionParams params) async {
    try {
      final prescriptionData = params.toJson();
      await dataSource.collection('prescriptions').add(prescriptionData);
      return Result.success();
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<PrescriptionModel>, Failure>> fetchPrescriptions(
    String patientId,
  ) async {
    try {
      final snapshot =
          await dataSource
              .collection('prescriptions')
              .where('patientId', isEqualTo: patientId)
              .get();

      final prescriptions =
          snapshot.docs.map((doc) {
            // Create model from data
            var model = PrescriptionModel.fromJson(doc.data());
            // Set the document ID as the model ID
            model = model.copyWith(id: doc.id);
            return model;
          }).toList();

      return Result.success(value: prescriptions);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }
}
