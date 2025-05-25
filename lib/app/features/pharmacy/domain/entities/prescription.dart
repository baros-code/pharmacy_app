import 'package:equatable/equatable.dart';

import '../../../../../core/utils/string_ext.dart';

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
  final DateTime issueDate;
  final List<String> attachments;

  String get medicationNames {
    return medicationIds
        .map(
          (e) =>
              '${e.split('_')[0].capitalizeFirstLetter()} (${e.split('_')[1]} ${e.split('_')[2]})',
        )
        .join('\n');
  }

  String get formattedIssueDate {
    return '${issueDate.day}/${issueDate.month}/${issueDate.year}';
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
