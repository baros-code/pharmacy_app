import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'home_page.desktop.dart';
import 'home_page.mobile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => HomePageMobile(),
      desktop: (_) => HomePageDesktop(),
    );
  }
}
