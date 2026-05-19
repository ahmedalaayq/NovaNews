import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nova_news/Features/auth/controller/auth_controller.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';
import 'package:nova_news/core/utils/assets.dart';
import 'package:nova_news/core/utils/utils.dart';
import 'package:nova_news/core/widgets/custom_elevated_button.dart';
import 'package:nova_news/core/widgets/password_strength_widget.dart';
import 'package:nova_news/core/widgets/shared_text_form_field.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final infiniteSize = MediaQuery.sizeOf(context);

    final controller = context.watch<AuthController>();
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 100,
        ),
        child: Form(
          key: controller.formKey,
          autovalidateMode: controller.autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              Center(
                child: Image.asset(
                  AppAssets.assetsImagesLogo,
                  height: 45,
                ),
              ),

              const SizedBox(height: 32),

              Text(
                'Welcome to Nova News',
                style: Theme.of(context).textTheme.titleLarge,
              ),

              const SizedBox(height: 24),

              Text(
                'Email',
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 8),

              SharedTextFormField(
                keyboardType: .emailAddress,
                focusNode: controller.emailFocus,
                controller: controller.emailController,
                hintText: 'ahmed@gmail.com',
                validator: (value) =>
                    Utils.emailFieldValidator(value),
                textInputAction: .next,
                onFieldSubmitted: (_) {
                  FocusScope.of(
                    context,
                  ).requestFocus(controller.passwordFocus);
                },
              ),

              const SizedBox(height: 16),

              Text(
                'Password',
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 8),

              SharedTextFormField(
                isPassword: true,
                keyboardType: .text,
                focusNode: controller.passwordFocus,
                controller: controller.passwordController,
                hintText: '*************',
                validator: (value) => Utils.passwordValidator(value),
                textInputAction: .next,
                onFieldSubmitted: (_) {
                  FocusScope.of(
                    context,
                  ).requestFocus(controller.confirmPasswordFocus);
                },
              ),

              const SizedBox(height: 16),

              Text(
                'Confirm Password',
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 8),

              SharedTextFormField(
                isPassword: true,
                keyboardType: .text,
                focusNode: controller.confirmPasswordFocus,
                controller: controller.confirmPasswordController,
                hintText: '*************',
                validator: (value) =>
                    controller.validateConfirmPassword(value),
                textInputAction: .done,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).unfocus();
                  controller.onSignUp(context);
                },
              ),
              const SizedBox(height: 14),

              ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller.passwordController,
                builder: (context, value, child) {
                  if (value.text.trim().isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Column(
                    children: [
                      const SizedBox(height: 14),

                      PasswordStrengthWidget(password: value.text),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),
              CustomElevatedButton(
                onPressed: () {
                  controller.onSignUp(context);
                },
                buttonText: 'Sign Up',
                child: controller.isLoading
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: LightAppColors.whitebgColor,
                        size: 20,
                      )
                    : Text('Sign Up'),
              ),

              const SizedBox(height: 24),

              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Have an account? ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextSpan(
                        text: 'Sign In',
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(
                              color: LightAppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  controller.errorMessage ?? "",
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(color: LightAppColors.primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
