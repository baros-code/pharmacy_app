import 'package:flutter/material.dart';

import '../../../../../core/presentation/controlled_view.dart';
import '../../../../shared/presentation/pages/base_page.dart';
import '../controllers/prescriptions_controller.dart';

class PrescriptionsPageDesktop
    extends ControlledView<PrescriptionsController, Object> {
  PrescriptionsPageDesktop({super.key, super.params});

  @override
  Widget build(BuildContext context) {
    return BasePage();
  }
}
