import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../core/presentation/controlled_view.dart';
import '../../../../shared/presentation/pages/base_page.dart';
import '../../../../shared/utils/asset_config.dart';
import '../../../../shared/utils/build_context_ext.dart';
import '../../../../shared/utils/validation_utils.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';
import '../controllers/login_controller.dart';

class LoginPageMobile extends ControlledView<LoginController, Object> {
  LoginPageMobile({super.key, super.params});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: _Title(),
      body: _Body(controller),
      centerTitle: true,
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text('Welcome back', style: context.textTheme.headlineLarge);
  }
}

class _Body extends StatefulWidget {
  const _Body(this.controller);

  final LoginController controller;

  @override
  State<_Body> createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Lets get you started.',
                style: context.textTheme.headlineSmall,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            CustomTextFormField(
              labelText: 'Email',
              hintText: 'Enter your email',
              onChanged: controller.setEmail,
              validator: ValidationUtils.emailValidator,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              obscureText: true,
              labelText: 'Password',
              hintText: 'Enter your password',
              onChanged: controller.setPassword,
              validator: ValidationUtils.passwordValidator,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  controller.login();
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: Divider(thickness: 1)),
                const SizedBox(width: 8),
                Text('Or', style: context.textTheme.headlineSmall),
                const SizedBox(width: 8),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: controller.loginWithGoogle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AssetConfig.googleLogo, width: 24, height: 24),
                  const SizedBox(width: 8),
                  const Text('Login with Google'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  style: context.textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: 'Sign up',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                      recognizer:
                          TapGestureRecognizer()..onTap = controller.goToSignUp,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
