import 'package:flutter/material.dart';

import '../../../../shared/presentation/pages/base_page.dart';
import '../../domain/entities/prescription.dart';

class PrescriptionDetailsPageDesktop extends StatelessWidget {
  const PrescriptionDetailsPageDesktop(this.prescription, {super.key});

  final Prescription prescription;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backButtonEnabled: true,
      title: _Title(prescription),
      body: _Body(prescription),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.prescription);

  final Prescription prescription;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Prescription #${prescription.id}',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.prescription);

  final Prescription prescription;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
