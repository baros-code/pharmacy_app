import 'package:equatable/equatable.dart';

class Medication extends Equatable {
  const Medication({
    required this.id,
    required this.name,
    required this.strength,
    required this.dosageForm,
    required this.description,
    required this.manufacturer,
    required this.price,
    required this.usage,
    required this.sideEffects,
    required this.category,
  });

  final String id;
  final String name;
  final String strength;
  final String dosageForm;
  final String description;
  final String manufacturer;
  final double? price;
  final String usage;
  final List<String> sideEffects;
  final String category;

  String get priceLabel {
    if (price == null) {
      return 'Price not available';
    }
    return '\$${price!.toStringAsFixed(2)}';
  }

  String get sideEffectsLabel {
    if (sideEffects.isEmpty) {
      return 'No known side effects';
    }
    return sideEffects.join(', ');
  }

  @override
  List<Object?> get props => [
    id,
    name,
    strength,
    dosageForm,
    description,
    manufacturer,
    price,
    usage,
    sideEffects,
    category,
  ];
}
