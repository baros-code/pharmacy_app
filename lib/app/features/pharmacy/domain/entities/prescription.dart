import 'package:equatable/equatable.dart';

class Prescription extends Equatable {
  const Prescription({
    required this.id,
    required this.patientId,
    required this.medicationIds,
    required this.additionalNotes,
    required this.issueDate,
    required this.attachments,
  });

  final String id;
  final String patientId;
  final List<String> medicationIds;
  final String additionalNotes;
  final DateTime? issueDate;
  final List<String> attachments;

  String get formattedIssueDate {
    if (issueDate == null) return 'No issue date';
    return '${issueDate!.day}/${issueDate!.month}/${issueDate!.year}';
  }

  @override
  List<Object?> get props => [
    id,
    patientId,
    medicationIds,
    additionalNotes,
    issueDate,
    attachments,
  ];
}
