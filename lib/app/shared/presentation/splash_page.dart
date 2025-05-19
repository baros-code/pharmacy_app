import 'package:flutter/material.dart';

import '../../../core/presentation/controlled_view.dart';
import '../controllers/splash_controller.dart';
import '../utils/asset_config.dart';
import '../utils/build_context_ext.dart';
import 'base_page.dart';

class SplashPage extends ControlledView<SplashController, Object> {
  SplashPage({super.key, super.params});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: const _Title(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetConfig.appLogo),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text('Splash Page', style: context.textTheme.headlineLarge);
  }
}
