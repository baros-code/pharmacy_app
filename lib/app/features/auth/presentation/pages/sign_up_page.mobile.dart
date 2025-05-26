import 'package:flutter/material.dart';

import '../../../../../core/presentation/controlled_view.dart';
import '../../../../shared/presentation/pages/base_page.dart';
import '../../../../shared/utils/build_context_ext.dart';
import '../../../../shared/utils/validation_utils.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';
import '../controllers/sign_up_controller.dart';

class SignUpPageMobile extends ControlledView<SignUpController, Object> {
  SignUpPageMobile({super.key, super.params});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      resizeToAvoidBottomInset: true,
      backButtonEnabled: true,
      body: _Body(controller),
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

class _Body extends StatefulWidget {
  const _Body(this.controller);

  final SignUpController controller;

  @override
  State<_Body> createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
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
              CustomTextFormField(
                onChanged: controller.setName,
                labelText: 'Name',
                validator: ValidationUtils.notEmptyValidator,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                onChanged: controller.setSurname,
                labelText: 'Surname',
                validator: ValidationUtils.notEmptyValidator,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                onChanged: controller.setEmail,
                labelText: 'Email',
                validator: ValidationUtils.emailValidator,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                onChanged: controller.setPassword,
                labelText: 'Password',
                obscureText: true,
                validator: ValidationUtils.passwordValidator,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                onChanged: controller.setConfirmPassword,
                labelText: 'Confirm password',
                obscureText: true,
                validator: controller.confirmPasswordValidator,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    controller.signUp();
                  }
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
