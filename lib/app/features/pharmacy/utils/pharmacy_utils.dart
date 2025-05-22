import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PharmacyUtils {
  static Future<void> deleteAllMedications() async {
    final collection = FirebaseFirestore.instance.collection('medications');
    final querySnapshot = await collection.get();

    final batch = FirebaseFirestore.instance.batch();
    for (final doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  static Future<void> addMedications() async {
    _addMedicationWithId(
      id: _generateMedicationId('Ibuprofen', '200mg', 'Tablet'),
      name: 'Ibuprofen',
      strength: '200mg',
      dosageForm: 'Tablet',
      description: 'Pain reliever and anti-inflammatory.',
      manufacturer: 'Example Pharma',
      price: 5.99,
    );

    _addMedicationWithId(
      id: _generateMedicationId('Paracetamol', '500mg', 'Tablet'),
      name: 'Paracetamol',
      strength: '500mg',
      dosageForm: 'Tablet',
      description: 'Pain reliever and fever reducer.',
      manufacturer: 'Example Pharma',
      price: 3.99,
    );

    _addMedicationWithId(
      id: _generateMedicationId('Amoxicillin', '250mg', 'Capsule'),
      name: 'Amoxicillin',
      strength: '250mg',
      dosageForm: 'Capsule',
      description: 'Antibiotic for bacterial infections.',
      manufacturer: 'Example Pharma',
      price: 10.99,
    );

    _addMedicationWithId(
      id: _generateMedicationId('Aspirin', '81mg', 'Tablet'),
      name: 'Aspirin',
      strength: '81mg',
      dosageForm: 'Tablet',
      description: 'Pain reliever and anti-inflammatory.',
      manufacturer: 'Example Pharma',
      price: 4.99,
    );

    _addMedicationWithId(
      id: _generateMedicationId('Lisinopril', '10mg', 'Tablet'),
      name: 'Lisinopril',
      strength: '10mg',
      dosageForm: 'Tablet',
      description: 'ACE inhibitor for hypertension.',
      manufacturer: 'Example Pharma',
      price: 7.99,
    );

    _addMedicationWithId(
      id: _generateMedicationId('Metformin', '500mg', 'Tablet'),
      name: 'Metformin',
      strength: '500mg',
      dosageForm: 'Tablet',
      description: 'Oral medication for type 2 diabetes.',
      manufacturer: 'Example Pharma',
      price: 8.99,
    );

    _addMedicationWithId(
      id: _generateMedicationId('Simvastatin', '20mg', 'Tablet'),
      name: 'Simvastatin',
      strength: '20mg',
      dosageForm: 'Tablet',
      description: 'Cholesterol-lowering medication.',
      manufacturer: 'Example Pharma',
      price: 9.99,
    );

    _addMedicationWithId(
      id: _generateMedicationId('Omeprazole', '20mg', 'Capsule'),
      name: 'Omeprazole',
      strength: '20mg',
      dosageForm: 'Capsule',
      description: 'Proton pump inhibitor for acid reflux.',
      manufacturer: 'Example Pharma',
      price: 6.99,
    );

    _addMedicationWithId(
      id: _generateMedicationId('Levothyroxine', '50mcg', 'Tablet'),
      name: 'Levothyroxine',
      strength: '50mcg',
      dosageForm: 'Tablet',
      description: 'Thyroid hormone replacement.',
      manufacturer: 'Example Pharma',
      price: 11.99,
    );

    _addMedicationWithId(
      id: _generateMedicationId('Gabapentin', '300mg', 'Capsule'),
      name: 'Gabapentin',
      strength: '300mg',
      dosageForm: 'Capsule',
      description: 'Medication for nerve pain.',
      manufacturer: 'Example Pharma',
      price: 12.99,
    );

    _addMedicationWithId(
      id: _generateMedicationId('Sertraline', '50mg', 'Tablet'),
      name: 'Sertraline',
      strength: '50mg',
      dosageForm: 'Tablet',
      description: 'Antidepressant medication.',
      manufacturer: 'Example Pharma',
      price: 13.99,
    );
  }

  // Helpers
  static Future<void> _addMedicationWithId({
    required String id,
    required String name,
    required String strength,
    required String dosageForm,
    required String description,
    required String manufacturer,
    required double price,
  }) async {
    final docRef = FirebaseFirestore.instance.collection('medications').doc(id);

    await docRef.set({
      'name': name,
      'strength': strength,
      'dosageForm': dosageForm,
      'description': description,
      'manufacturer': manufacturer,
      'price': price,
      'isActive': true,
    });
  }

  static String _generateMedicationId(
    String name,
    String strength,
    String dosageForm,
  ) {
    return '''${name.trim().toLowerCase()}_${strength.trim().toLowerCase()}_${dosageForm.trim().toLowerCase()}'''
        .replaceAll(RegExp(r'\s+'), '_')
        .replaceAll(RegExp(r'[^\w\-]'), '');
  }
  // - Helpers
}
