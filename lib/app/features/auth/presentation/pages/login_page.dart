import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'login_page.desktop.dart';
import 'login_page.mobile.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => LoginPageMobile(),
      desktop: (_) => LoginPageDesktop(),
    );
  }
}
