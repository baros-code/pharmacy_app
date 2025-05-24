import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'prescriptions_page.desktop.dart';
import 'prescriptions_page.mobile.dart';

class PrescriptionsPage extends StatelessWidget {
  const PrescriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => PrescriptionsPageMobile(),
      desktop: (_) => PrescriptionsPageDesktop(),
    );
  }
}
