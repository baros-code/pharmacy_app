import 'package:json_annotation/json_annotation.dart';

import '../../../../shared/utils/app_config.dart';
import '../../domain/entities/medication.dart';

part 'medication_model.g.dart';

@JsonSerializable()
class MedicationModel {
  MedicationModel({
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

  final String? id;
  final String? name;
  final String? strength;
  final String? dosageForm;
  final String? description;
  final String? manufacturer;
  final double? price;
  final String? usage;
  final List<String>? sideEffects;
  final String? category;

  factory MedicationModel.fromJson(Map<String, dynamic> json) =>
      _$MedicationModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicationModelToJson(this);

  factory MedicationModel.fromEntity(Medication entity) => MedicationModel(
    id: entity.id,
    name: entity.name,
    strength: entity.strength,
    dosageForm: entity.dosageForm,
    description: entity.description,
    manufacturer: entity.manufacturer,
    price: entity.price,
    usage: entity.usage,
    sideEffects: entity.sideEffects,
    category: entity.category,
  );

  Medication toEntity() {
    return Medication(
      id: id ?? AppConfig.defaultString,
      name: name ?? AppConfig.defaultString,
      strength: strength ?? AppConfig.defaultString,
      dosageForm: dosageForm ?? AppConfig.defaultString,
      description: description ?? AppConfig.defaultString,
      manufacturer: manufacturer ?? AppConfig.defaultString,
      price: price,
      usage: usage ?? AppConfig.defaultString,
      sideEffects: sideEffects ?? [],
      category: category ?? AppConfig.defaultString,
    );
  }
}
