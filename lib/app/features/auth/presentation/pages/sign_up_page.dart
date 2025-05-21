import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'sign_up_page.desktop.dart';
import 'sign_up_page.mobile.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => SignUpPageMobile(),
      desktop: (_) => SignUpPageDesktop(),
    );
  }
}
