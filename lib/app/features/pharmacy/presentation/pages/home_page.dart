import 'package:flutter/material.dart';

import '../../../../../core/presentation/controlled_view.dart';
import '../../../../shared/presentation/base_page.dart';
import '../../../../shared/utils/build_context_ext.dart';
import '../controllers/home_controller.dart';

class HomePage extends ControlledView<HomeController, Object> {
  HomePage({super.key, super.params});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: _Title(),
      body: const Center(child: Text('Home Page')),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text('Pharmacy', style: context.textTheme.headlineLarge);
  }
}
