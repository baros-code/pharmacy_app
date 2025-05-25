// ignore_for_file: lines_longer_than_80_chars

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
      name: 'ibuprofen',
      strength: '200mg',
      dosageForm: 'Tablet',
      description: 'Pain reliever and anti-inflammatory.',
      manufacturer: 'Example Pharma',
      price: 5.99,
      usage:
          'Take 1 tablet every 4–6 hours with food. Do not exceed 6 tablets in 24 hours.',
      sideEffects: ['Nausea', 'Heartburn', 'Dizziness'],
      category: 'Pain Reliever',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Paracetamol', '500mg', 'Tablet'),
      name: 'paracetamol',
      strength: '500mg',
      dosageForm: 'Tablet',
      description: 'Pain reliever and fever reducer.',
      manufacturer: 'Example Pharma',
      price: 3.99,
      usage:
          'Take 1 tablet every 4–6 hours as needed. Do not exceed 4g per day.',
      sideEffects: ['Liver damage (high dose)', 'Rash', 'Nausea'],
      category: 'Pain Reliever',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Amoxicillin', '250mg', 'Capsule'),
      name: 'amoxicillin',
      strength: '250mg',
      dosageForm: 'Capsule',
      description: 'Antibiotic for bacterial infections.',
      manufacturer: 'Example Pharma',
      price: 10.99,
      usage:
          'Take 1 capsule every 8 hours. Complete the full course even if you feel better.',
      sideEffects: ['Diarrhea', 'Nausea', 'Skin rash'],
      category: 'Antibiotic',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Aspirin', '81mg', 'Tablet'),
      name: 'aspirin',
      strength: '81mg',
      dosageForm: 'Tablet',
      description: 'Pain reliever and anti-inflammatory.',
      manufacturer: 'Example Pharma',
      price: 4.99,
      usage:
          'Take 1 tablet daily with food or as directed. Avoid on an empty stomach.',
      sideEffects: ['Gastrointestinal bleeding', 'Ringing in ears', 'Nausea'],
      category: 'Blood Thinner',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Lisinopril', '10mg', 'Tablet'),
      name: 'lisinopril',
      strength: '10mg',
      dosageForm: 'Tablet',
      description: 'ACE inhibitor for hypertension.',
      manufacturer: 'Example Pharma',
      price: 7.99,
      usage:
          'Take 1 tablet daily at the same time each day, with or without food.',
      sideEffects: ['Dry cough', 'Dizziness', 'Fatigue'],
      category: 'Cardiovascular',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Metformin', '500mg', 'Tablet'),
      name: 'metformin',
      strength: '500mg',
      dosageForm: 'Tablet',
      description: 'Oral medication for type 2 diabetes.',
      manufacturer: 'Example Pharma',
      price: 8.99,
      usage:
          'Take with meals 1–2 times daily. Do not crush or chew extended-release tablets.',
      sideEffects: ['Stomach upset', 'Metallic taste', 'Diarrhea'],
      category: 'Antidiabetic',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Simvastatin', '20mg', 'Tablet'),
      name: 'simvastatin',
      strength: '20mg',
      dosageForm: 'Tablet',
      description: 'Cholesterol-lowering medication.',
      manufacturer: 'Example Pharma',
      price: 9.99,
      usage: 'Take 1 tablet in the evening. Avoid grapefruit and alcohol.',
      sideEffects: ['Muscle pain', 'Liver enzyme increase', 'Constipation'],
      category: 'Cholesterol',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Omeprazole', '20mg', 'Capsule'),
      name: 'omeprazole',
      strength: '20mg',
      dosageForm: 'Capsule',
      description: 'Proton pump inhibitor for acid reflux.',
      manufacturer: 'Example Pharma',
      price: 6.99,
      usage: 'Take 1 capsule 30 minutes before breakfast for 4–8 weeks.',
      sideEffects: ['Headache', 'Abdominal pain', 'Nausea'],
      category: 'Gastrointestinal',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Levothyroxine', '50mcg', 'Tablet'),
      name: 'levothyroxine',
      strength: '50mcg',
      dosageForm: 'Tablet',
      description: 'Thyroid hormone replacement.',
      manufacturer: 'Example Pharma',
      price: 11.99,
      usage: 'Take in the morning on an empty stomach, 30 minutes before food.',
      sideEffects: ['Insomnia', 'Weight loss', 'Palpitations'],
      category: 'Hormonal',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Gabapentin', '300mg', 'Capsule'),
      name: 'gabapentin',
      strength: '300mg',
      dosageForm: 'Capsule',
      description: 'Medication for nerve pain.',
      manufacturer: 'Example Pharma',
      price: 12.99,
      usage:
          'Start with 1 capsule at night. Increase dose as prescribed by doctor.',
      sideEffects: ['Drowsiness', 'Dizziness', 'Swelling'],
      category: 'Neurological',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Sertraline', '50mg', 'Tablet'),
      name: 'sertraline',
      strength: '50mg',
      dosageForm: 'Tablet',
      description: 'Antidepressant medication.',
      manufacturer: 'Example Pharma',
      price: 13.99,
      usage:
          'Take 1 tablet daily, preferably in the morning. May take several weeks to work.',
      sideEffects: ['Sexual dysfunction', 'Insomnia', 'Nausea'],
      category: 'Antidepressant',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Alprazolam', '0.5mg', 'Tablet'),
      name: 'alprazolam',
      strength: '0.5mg',
      dosageForm: 'Tablet',
      description: 'Used to treat anxiety and panic disorders.',
      manufacturer: 'Anxiomed',
      price: 6.50,
      usage: 'Take 1 tablet as needed for anxiety, up to 3 times daily.',
      sideEffects: ['Drowsiness', 'Fatigue', 'Dependency'],
      category: 'Anxiolytic',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Cetirizine', '10mg', 'Tablet'),
      name: 'cetirizine',
      strength: '10mg',
      dosageForm: 'Tablet',
      description: 'Allergy relief antihistamine.',
      manufacturer: 'AllerCare',
      price: 4.20,
      usage: 'Take 1 tablet daily for allergy symptoms.',
      sideEffects: ['Drowsiness', 'Dry mouth', 'Headache'],
      category: 'Antihistamine',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Clopidogrel', '75mg', 'Tablet'),
      name: 'clopidogrel',
      strength: '75mg',
      dosageForm: 'Tablet',
      description: 'Prevents blood clots after heart attack or stroke.',
      manufacturer: 'CardioPharm',
      price: 8.10,
      usage: 'Take 1 tablet daily with or without food.',
      sideEffects: ['Bleeding', 'Bruising', 'Stomach pain'],
      category: 'Antiplatelet',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Fluoxetine', '20mg', 'Capsule'),
      name: 'fluoxetine',
      strength: '20mg',
      dosageForm: 'Capsule',
      description: 'Treats depression, OCD, and anxiety.',
      manufacturer: 'NeuroPharma',
      price: 9.75,
      usage: 'Take 1 capsule daily in the morning.',
      sideEffects: ['Nausea', 'Insomnia', 'Headache'],
      category: 'Antidepressant',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Montelukast', '10mg', 'Tablet'),
      name: 'montelukast',
      strength: '10mg',
      dosageForm: 'Tablet',
      description: 'Prevents asthma and allergy symptoms.',
      manufacturer: 'BreathEase',
      price: 5.50,
      usage: 'Take 1 tablet in the evening.',
      sideEffects: ['Sleep disturbance', 'Nausea', 'Dizziness'],
      category: 'Respiratory',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Doxycycline', '100mg', 'Capsule'),
      name: 'doxycycline',
      strength: '100mg',
      dosageForm: 'Capsule',
      description: 'Broad-spectrum antibiotic.',
      manufacturer: 'AntibioGen',
      price: 7.25,
      usage: 'Take 1 capsule twice daily with plenty of water.',
      sideEffects: ['Photosensitivity', 'Nausea', 'Vomiting'],
      category: 'Antibiotic',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Losartan', '50mg', 'Tablet'),
      name: 'losartan',
      strength: '50mg',
      dosageForm: 'Tablet',
      description: 'Used to treat high blood pressure.',
      manufacturer: 'HeartMed',
      price: 6.99,
      usage: 'Take 1 tablet daily.',
      sideEffects: ['Dizziness', 'Back pain', 'Cough'],
      category: 'Antihypertensive',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Hydrochlorothiazide', '25mg', 'Tablet'),
      name: 'hydrochlorothiazide',
      strength: '25mg',
      dosageForm: 'Tablet',
      description: 'Diuretic for high blood pressure and fluid retention.',
      manufacturer: 'Diurex',
      price: 3.80,
      usage: 'Take 1 tablet in the morning.',
      sideEffects: ['Frequent urination', 'Dehydration', 'Dizziness'],
      category: 'Diuretic',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Warfarin', '5mg', 'Tablet'),
      name: 'warfarin',
      strength: '5mg',
      dosageForm: 'Tablet',
      description: 'Blood thinner to prevent clots.',
      manufacturer: 'ThromboMed',
      price: 10,
      usage: 'Take as directed and monitor INR regularly.',
      sideEffects: ['Bleeding', 'Bruising', 'Nausea'],
      category: 'Anticoagulant',
    );

    _addMedicationWithId(
      id: _generateMedicationId('Ranitidine', '150mg', 'Tablet'),
      name: 'ranitidine',
      strength: '150mg',
      dosageForm: 'Tablet',
      description: 'Reduces stomach acid for heartburn.',
      manufacturer: 'DigestMed',
      price: 4.45,
      usage: 'Take 1 tablet twice daily before meals.',
      sideEffects: ['Constipation', 'Dizziness', 'Fatigue'],
      category: 'Gastrointestinal',
    );
  }

  static Future<void> _addMedicationWithId({
    required String id,
    required String name,
    required String strength,
    required String dosageForm,
    required String description,
    required String manufacturer,
    required double price,
    required String usage,
    required List<String> sideEffects,
    required String category,
  }) async {
    final docRef = FirebaseFirestore.instance.collection('medications').doc(id);

    await docRef.set({
      'id': id,
      'name': name,
      'strength': strength,
      'dosageForm': dosageForm,
      'description': description,
      'manufacturer': manufacturer,
      'price': price,
      'usage': usage,
      'sideEffects': sideEffects,
      'category': category,
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
