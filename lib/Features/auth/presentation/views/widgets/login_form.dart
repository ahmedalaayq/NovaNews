import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/router/app_routes.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/shared_text_form_field.dart';
import '../../../controller/auth_controller_cubit.dart';
import '../../../controller/auth_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  late final FocusNode emailFocus;
  late final FocusNode passwordFocus;

  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();

    emailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    emailFocus.dispose();
    passwordFocus.dispose();

    super.dispose();
  }

  void _login() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      setState(() {
        autoValidateMode = AutovalidateMode.always;
      });
      return;
    }

    FocusScope.of(context).unfocus();

    context.read<AuthControllerCubit>().signIn(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthControllerCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainView, (_) => false);
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: Form(
        key: _formKey,
        autovalidateMode: autoValidateMode,
        child: Column(
          children: [
            SharedTextFormField(
              controller: emailController,
              focusNode: emailFocus,
              hintText: 'Email',
              validator: (value) => Utils.emailFieldValidator(value),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(passwordFocus);
              },
            ),

            const SizedBox(height: 16),

            SharedTextFormField(
              controller: passwordController,
              focusNode: passwordFocus,
              hintText: 'Password',
              isPassword: true,
              validator: (value) => Utils.passwordValidator(value),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _login(),
            ),

            const SizedBox(height: 24),

            BlocSelector<AuthControllerCubit, AuthState, bool>(
              selector: (state) => state is AuthLoading,
              builder: (context, isLoading) {
                return CustomElevatedButton(
                  onPressed: isLoading ? null : _login,
                  buttonText: 'Sign In',
                  child: isLoading ? const CircularProgressIndicator() : const Text('Sign In'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
