import 'package:flutter/material.dart';

import '../../../../shared/presentation/pages/base_page.dart';
import '../../../../shared/presentation/widgets/label_and_value.dart';
import '../../../../shared/utils/date_time_ext.dart';
import '../../domain/entities/prescription.dart';

class PrescriptionDetailsPageDesktop extends StatelessWidget {
  const PrescriptionDetailsPageDesktop(this.prescription, {super.key});

  final Prescription prescription;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backButtonEnabled: true,
      title: _Title(),
      body: _Body(prescription),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Prescription details',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.prescription);

  final Prescription prescription;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelAndValue('Prescription ID: ', prescription.id),
            const SizedBox(height: 8),
            LabelAndValue('Medication Names: ', prescription.medicationNames),
            const SizedBox(height: 8),
            LabelAndValue(
              'Issue Date: ',
              prescription.issueDate.formatDefault(),
            ),
            const SizedBox(height: 8),
            LabelAndValue('Additional Notes: ', '--'),
            const SizedBox(height: 8),
            LabelAndValue(
              'Attachments: ',
              prescription.attachments.isNotEmpty
                  ? '''For now the attachments feature is only available on mobile devices.'''
                  : '--',
            ),
          ],
        ),
      ),
    );
  }
}
