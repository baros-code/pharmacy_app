import 'package:json_annotation/json_annotation.dart';

import '../../../../shared/utils/app_config.dart';
import '../../domain/entities/prescription.dart';

part 'prescription_model.g.dart';

@JsonSerializable()
class PrescriptionModel {
  PrescriptionModel({
    required this.id,
    required this.patientId,
    required this.medicationIds,
    required this.additionalNotes,
    required this.issueDate,
    required this.attachments,
  });

  final String? id;
  final String? patientId;
  final List<String>? medicationIds;
  @JsonKey(name: 'instructions')
  final String? additionalNotes;
  final DateTime? issueDate;
  final List<String>? attachments;

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionModelToJson(this);

  factory PrescriptionModel.fromEntity(Prescription entity) =>
      PrescriptionModel(
        id: entity.id,
        patientId: entity.patientId,
        medicationIds: entity.medicationIds,
        additionalNotes: entity.additionalNotes,
        issueDate: entity.issueDate,
        attachments: entity.attachments,
      );

  Prescription toEntity() {
    return Prescription(
      id: id ?? AppConfig.defaultString,
      patientId: patientId ?? AppConfig.defaultString,
      medicationIds: medicationIds ?? [],
      additionalNotes: additionalNotes ?? AppConfig.defaultString,
      issueDate: issueDate ?? DateTime(1),
      attachments: attachments ?? [],
    );
  }

  PrescriptionModel copyWith({
    String? id,
    String? patientId,
    List<String>? medicationIds,
    String? additionalNotes,
    DateTime? issueDate,
    List<String>? attachments,
  }) {
    return PrescriptionModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      medicationIds: medicationIds ?? this.medicationIds,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      issueDate: issueDate ?? this.issueDate,
      attachments: attachments ?? this.attachments,
    );
  }
}
