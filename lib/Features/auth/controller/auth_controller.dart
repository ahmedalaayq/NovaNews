import 'package:flutter/material.dart';
import 'package:nova_news/core/datasource/local/preference_manager.dart';
import 'package:nova_news/core/datasource/local/storage_key.dart';
import 'package:nova_news/core/mixins/safe_notify_mixin.dart';
import 'package:nova_news/core/router/app_routes.dart';

class AuthController with ChangeNotifier, SafeNotifyMixin {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController usernameController;

  late FocusNode usernameFocus;
  late FocusNode emailFocus;
  late FocusNode passwordFocus;
  late FocusNode confirmPasswordFocus;

  late GlobalKey<FormState> formKey;
  late AutovalidateMode autovalidateMode;
  String? savedEmail = '';
  String? errorMessage;
  bool isLoading = false;

  void init() {
    emailController = TextEditingController(text: savedEmail);
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    usernameController = TextEditingController();

    usernameFocus = FocusNode();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    confirmPasswordFocus = FocusNode();

    formKey = GlobalKey<FormState>();
    autovalidateMode = AutovalidateMode.onUserInteraction;
  }

  Future<void> onSignIn(BuildContext context) async {
    errorMessage = null;
    safeNotify();

    if (!(formKey.currentState?.validate() ?? false)) {
      autovalidateMode = AutovalidateMode.always;
      safeNotify();
      return;
    }

    FocusScope.of(context).unfocus();

    isLoading = true;
    safeNotify();

    await Future.delayed(const Duration(seconds: 2));

    final retrievedEmail = PreferenceManager.getData<String>(StorageKey.savedEmail);

    final retrievedPassword = PreferenceManager.getData<String>(StorageKey.savedPassword);

    final enteredEmail = emailController.text.trim();

    final enteredPassword = passwordController.text.trim();

    if (retrievedEmail == null ||
        retrievedPassword == null ||
        enteredEmail != retrievedEmail ||
        enteredPassword != retrievedPassword) {
      errorMessage = 'Email or password is incorrect';

      isLoading = false;
      safeNotify();

      return;
    }

    isLoading = false;
    clearState();

    safeNotify();

    await PreferenceManager.setData<bool>(StorageKey.isLoggedIn, true);

    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainView, (route) => false);
  }

  Future<void> onSignUp(BuildContext context) async {
    errorMessage = null;
    safeNotify();

    if (!(formKey.currentState?.validate() ?? false)) {
      autovalidateMode = AutovalidateMode.always;
      safeNotify();
      return;
    }

    FocusScope.of(context).unfocus();

    isLoading = true;
    safeNotify();

    await Future.delayed(const Duration(seconds: 2));

    final savedEmail = PreferenceManager.getData<String>(StorageKey.savedEmail);

    if (savedEmail != null && savedEmail == emailController.text.trim()) {
      errorMessage = 'Email already exists';

      isLoading = false;
      safeNotify();

      return;
    }

    await PreferenceManager.setData<String>(StorageKey.savedEmail, emailController.text.trim());
    await PreferenceManager.setData<String>(
      StorageKey.savedPassword,
      passwordController.text.trim(),
    );
    await PreferenceManager.setData<String>(StorageKey.username, usernameController.text.trim());

    isLoading = false;
    clearState();
    await PreferenceManager.setData<bool>(StorageKey.isLoggedIn, true);
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainView, (route) => false);
    safeNotify();
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Confirm Password Field is Required';
    }

    if (passwordController.text.trim() != value.trim()) {
      return 'Password doesn\'t match';
    }

    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();

    super.dispose();
  }

  void clearState() {
    formKey.currentState?.reset();

    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();

    errorMessage = null;

    autovalidateMode = AutovalidateMode.onUserInteraction;

    safeNotify();
  }

  Future<void> _onSavedEmail() async {
    await PreferenceManager.setData<String>(StorageKey.savedEmail, emailController.text.trim());
  }
}
