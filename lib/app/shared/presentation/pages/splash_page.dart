import 'package:flutter/material.dart';

import '../../../../core/presentation/controlled_view.dart';
import '../../controllers/splash_controller.dart';
import '../../utils/asset_config.dart';
import 'base_page.dart';

class SplashPage extends ControlledView<SplashController, Object> {
  SplashPage({super.key, super.params});

  @override
  Widget build(BuildContext context) {
    return BasePage(
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
