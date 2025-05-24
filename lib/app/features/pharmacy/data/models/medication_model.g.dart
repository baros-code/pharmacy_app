// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicationModel _$MedicationModelFromJson(Map<String, dynamic> json) =>
    MedicationModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      strength: json['strength'] as String?,
      dosageForm: json['dosageForm'] as String?,
      description: json['description'] as String?,
      manufacturer: json['manufacturer'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      usage: json['usage'] as String?,
      sideEffects:
          (json['sideEffects'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      category: json['category'] as String?,
    );

Map<String, dynamic> _$MedicationModelToJson(MedicationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'strength': instance.strength,
      'dosageForm': instance.dosageForm,
      'description': instance.description,
      'manufacturer': instance.manufacturer,
      'price': instance.price,
      'usage': instance.usage,
      'sideEffects': instance.sideEffects,
      'category': instance.category,
    };
