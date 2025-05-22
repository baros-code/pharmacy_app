import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/presentation/controller.dart';

// TODO(Baran): Test the app with ios, sign in e.g
class HomeController extends Controller<Object> {
  HomeController(super.logger, super.popupManager);

  @override
  void onStart() {
    super.onStart();
    addMedication(
      name: 'Ibuprofen',
      strength: '200mg',
      dosageForm: 'Tablet',
      description: 'Pain reliever and anti-inflammatory.',
      manufacturer: 'Example Pharma',
      price: 5.99,
    );
    addMedication(
      name: 'Paracetamol',
      strength: '500mg',
      dosageForm: 'Tablet',
      description: 'Pain reliever and fever reducer.',
      manufacturer: 'Example Pharma',
      price: 3.99,
    );
    addMedication(
      name: 'Amoxicillin',
      strength: '250mg',
      dosageForm: 'Capsule',
      description: 'Antibiotic for bacterial infections.',
      manufacturer: 'Example Pharma',
      price: 10.99,
    );
    addMedication(
      name: 'Aspirin',
      strength: '81mg',
      dosageForm: 'Tablet',
      description: 'Pain reliever and anti-inflammatory.',
      manufacturer: 'Example Pharma',
      price: 4.99,
    );
    addMedication(
      name: 'Lisinopril',
      strength: '10mg',
      dosageForm: 'Tablet',
      description: 'ACE inhibitor for hypertension.',
      manufacturer: 'Example Pharma',
      price: 7.99,
    );
    addMedication(
      name: 'Metformin',
      strength: '500mg',
      dosageForm: 'Tablet',
      description: 'Oral medication for type 2 diabetes.',
      manufacturer: 'Example Pharma',
      price: 8.99,
    );
    addMedication(
      name: 'Simvastatin',
      strength: '20mg',
      dosageForm: 'Tablet',
      description: 'Cholesterol-lowering medication.',
      manufacturer: 'Example Pharma',
      price: 9.99,
    );
    addMedication(
      name: 'Omeprazole',
      strength: '20mg',
      dosageForm: 'Capsule',
      description: 'Proton pump inhibitor for acid reflux.',
      manufacturer: 'Example Pharma',
      price: 6.99,
    );
    addMedication(
      name: 'Levothyroxine',
      strength: '50mcg',
      dosageForm: 'Tablet',
      description: 'Thyroid hormone replacement.',
      manufacturer: 'Example Pharma',
      price: 11.99,
    );
    addMedication(
      name: 'Gabapentin',
      strength: '300mg',
      dosageForm: 'Capsule',
      description: 'Medication for nerve pain.',
      manufacturer: 'Example Pharma',
      price: 12.99,
    );
    addMedication(
      name: 'Sertraline',
      strength: '50mg',
      dosageForm: 'Tablet',
      description: 'Antidepressant medication.',
      manufacturer: 'Example Pharma',
      price: 13.99,
    );
  }

  Future<void> addMedication({
    required String name,
    required String strength,
    required String dosageForm,
    required String description,
    required String manufacturer,
    required double price,
    bool isActive = true,
  }) async {
    try {
      // Get a reference to the 'medications' collection
      CollectionReference medications = FirebaseFirestore.instance.collection(
        'medications',
      );

      // Add a new document with a generated ID
      await medications.add({
        'name': name,
        'strength': strength,
        'dosageForm': dosageForm,
        'description': description,
        'manufacturer': manufacturer,
        'price': price,
        'isActive': isActive,
        // You could add timestamps like 'createdAt': FieldValue.serverTimestamp()
      });

      print("Medication added successfully!");
    } catch (e) {
      print("Error adding medication: $e");
      // Handle the error appropriately in your UI
    }
  }
}
