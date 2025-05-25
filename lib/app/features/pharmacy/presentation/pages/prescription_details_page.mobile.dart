import 'package:flutter/material.dart';

import '../../../../shared/presentation/pages/base_page.dart';
import '../../domain/entities/prescription.dart';

class PrescriptionDetailsPageMobile extends StatelessWidget {
  const PrescriptionDetailsPageMobile(this.prescription, {super.key});

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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LabelField('Prescription ID: ', prescription.id),
          const SizedBox(height: 8),
          _LabelField('Medication Names: ', prescription.medicationNames),
        ],
      ),
    );
  }
}

class _LabelField extends StatelessWidget {
  const _LabelField(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: Theme.of(context).disabledColor,
        ),
        children: [
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
