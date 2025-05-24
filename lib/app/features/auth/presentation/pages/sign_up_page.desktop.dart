import 'package:flutter/material.dart';

import '../../../../../core/presentation/controlled_view.dart';
import '../../../../../core/presentation/sub_view.dart';
import '../../../../shared/presentation/pages/base_page.dart';
import '../../../../shared/utils/build_context_ext.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';
import '../controllers/sign_up_controller.dart';

class SignUpPageDesktop extends ControlledView<SignUpController, Object> {
  SignUpPageDesktop({super.key, super.params});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backButtonEnabled: true,
      body: _Body(),
      title: _Title(),
      centerTitle: true,
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text('Register', style: context.textTheme.headlineLarge);
  }
}

class _Body extends SubView<SignUpController> {
  @override
  Widget buildView(BuildContext context, SignUpController controller) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.35,
        vertical: screenHeight * 0.1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              'Create an account.',
              style: context.textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: screenHeight * 0.1),
          CustomTextFormField(onChanged: controller.setName, labelText: 'Name'),
          const SizedBox(height: 16),
          CustomTextFormField(
            onChanged: controller.setSurname,
            labelText: 'Surname',
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            onChanged: controller.setEmail,
            labelText: 'Email',
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            onChanged: controller.setPassword,
            labelText: 'Password',
            obscureText: true,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            onChanged: controller.setConfirmPassword,
            labelText: 'Confirm password',
            obscureText: true,
          ),
          const Spacer(),
          StreamBuilder(
            stream: controller.signUpFieldsStream,
            builder: (_, snapshot) {
              return ElevatedButton(
                onPressed: snapshot.data == true ? controller.signUp : null,
                child: const Text('Sign Up'),
              );
            },
          ),
        ],
      ),
    );
  }
}
