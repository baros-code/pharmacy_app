import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'create_prescriptions_page.desktop.dart';
import 'create_prescriptions_page.mobile.dart';

class CreatePrescriptionsPage extends StatelessWidget {
  const CreatePrescriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => CreatePrescriptionsPageMobile(),
      desktop: (_) => CreatePrescriptionsPageDesktop(),
    );
  }
}
