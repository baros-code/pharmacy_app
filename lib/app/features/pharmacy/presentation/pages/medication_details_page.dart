import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../domain/entities/medication.dart';
import 'medication_details_page.desktop.dart';
import 'medication_details_page.mobile.dart';

class MedicationDetailsPage extends StatelessWidget {
  const MedicationDetailsPage(this.medication, {super.key});

  final Medication medication;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => MedicationDetailsPageMobile(medication),
      desktop: (_) => MedicationDetailsPageDesktop(medication),
    );
  }
}
