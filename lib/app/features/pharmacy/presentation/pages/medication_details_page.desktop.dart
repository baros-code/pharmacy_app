import 'package:flutter/material.dart';

import '../../../../../core/utils/string_ext.dart';
import '../../../../shared/presentation/pages/base_page.dart';
import '../../domain/entities/medication.dart';

class MedicationDetailsPageDesktop extends StatelessWidget {
  const MedicationDetailsPageDesktop(this.medication, {super.key});

  final Medication medication;

  @override
  Widget build(BuildContext context) {
    return BasePage(backButtonEnabled: true, title: _Title(medication.name));
  }
}

class _Title extends StatelessWidget {
  const _Title(this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name.capitalizeFirstLetter(),
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
