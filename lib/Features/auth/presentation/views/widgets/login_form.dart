import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nova_news/Features/auth/controller/auth_controller.dart';
import 'package:nova_news/core/router/app_routes.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';
import 'package:nova_news/core/utils/assets.dart';
import 'package:nova_news/core/utils/utils.dart';
import 'package:nova_news/core/widgets/custom_elevated_button.dart';
import 'package:nova_news/core/widgets/shared_text_form_field.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AuthController>();

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

              Consumer<AuthController>(
                builder:
                    (BuildContext context, value, Widget? child) {
                      return SharedTextFormField(
                        isPassword: true,
                        keyboardType: .text,
                        focusNode: value.passwordFocus,
                        controller: value.passwordController,
                        hintText: '*************',
                        validator: (value) =>
                            Utils.passwordValidator(value),
                        textInputAction: .done,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).unfocus();
                        },
                      );
                    },
              ),

              const SizedBox(height: 16),

              const SizedBox(height: 24),

              Selector<AuthController, bool>(
                builder: (BuildContext context, value, Widget? child) {
                  return CustomElevatedButton(
                    onPressed: () {
                      controller.onSignIn(context);
                    },
                    buttonText: 'Sign In',
                    child: value
                        ? LoadingAnimationWidget.staggeredDotsWave(
                            color: LightAppColors.whiteBgColor,
                            size: 20,
                          )
                        : Text('Sign In'),
                  );
                },
                selector: (BuildContext p1, p2) {
                  return p2.isLoading;
                },
              ),
              const SizedBox(height: 24),

              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don\'t have an account ? ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextSpan(
                        text: 'Sign Up',
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(
                              color: LightAppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.registerView,
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Consumer<AuthController>(
                builder:
                    (BuildContext context, value, Widget? child) {
                      return Center(
                        child: Text(
                          value.errorMessage ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: LightAppColors.primaryColor,
                              ),
                        ),
                      );
                    },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
