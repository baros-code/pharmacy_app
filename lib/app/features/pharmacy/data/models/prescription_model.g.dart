// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionModel _$PrescriptionModelFromJson(Map<String, dynamic> json) =>
    PrescriptionModel(
      id: json['id'] as String?,
      patientId: json['patientId'] as String?,
      medicationIds:
          (json['medicationIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      additionalNotes: json['instructions'] as String?,
      issueDate:
          json['issueDate'] == null
              ? null
              : DateTime.parse(json['issueDate'] as String),
      attachments:
          (json['attachments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$PrescriptionModelToJson(PrescriptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patientId': instance.patientId,
      'medicationIds': instance.medicationIds,
      'instructions': instance.additionalNotes,
      'issueDate': instance.issueDate?.toIso8601String(),
      'attachments': instance.attachments,
    };
