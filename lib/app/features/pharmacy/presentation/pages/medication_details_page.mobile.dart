import 'package:flutter/material.dart';

import '../../../../../core/utils/string_ext.dart';
import '../../../../shared/presentation/pages/base_page.dart';
import '../../../../shared/presentation/widgets/label_and_value.dart';
import '../../domain/entities/medication.dart';

class MedicationDetailsPageMobile extends StatelessWidget {
  const MedicationDetailsPageMobile(this.medication, {super.key});

  final Medication medication;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backButtonEnabled: true,
      title: _Title(medication.name),
      body: _Body(medication),
    );
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

class _Body extends StatelessWidget {
  const _Body(this.medication);

  final Medication medication;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          LabelAndValue('Description', medication.description),
          LabelAndValue('Dosage', medication.dosageForm),
          LabelAndValue('Price', medication.priceLabel),
          LabelAndValue('Side effects', medication.sideEffectsLabel),
          LabelAndValue('Usage', medication.usage),
          LabelAndValue('Manufacturer', medication.manufacturer),
        ],
      ),
    );
  }
}
