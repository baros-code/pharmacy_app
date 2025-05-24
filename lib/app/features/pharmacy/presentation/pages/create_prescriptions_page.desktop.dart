import 'package:flutter/material.dart';

import '../../../../../core/presentation/controlled_view.dart';
import '../../../../shared/presentation/pages/base_page.dart';
import '../controllers/create_prescriptions_controller.dart';

class CreatePrescriptionsPageDesktop
    extends ControlledView<CreatePrescriptionsController, Object> {
  CreatePrescriptionsPageDesktop({super.key, super.params});

  @override
  Widget build(BuildContext context) {
    return BasePage();
  }
}
