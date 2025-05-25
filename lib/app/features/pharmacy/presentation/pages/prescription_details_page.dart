import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../domain/entities/prescription.dart';
import 'prescription_details_page.desktop.dart';
import 'prescription_details_page.mobile.dart';

class PrescriptionDetailsPage extends StatelessWidget {
  const PrescriptionDetailsPage(this.prescription, {super.key});

  final Prescription prescription;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => PrescriptionDetailsPageMobile(prescription),
      desktop: (_) => PrescriptionDetailsPageDesktop(prescription),
    );
  }
}
