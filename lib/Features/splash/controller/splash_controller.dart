import 'package:flutter/material.dart';
import 'package:nova_news/core/datasource/local/preference_manager.dart';
import 'package:nova_news/core/datasource/local/storage_key.dart';
import 'package:nova_news/core/router/app_routes.dart';
class SplashController with ChangeNotifier {
  void executeNavigation(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));

    final bool isLoggedIn =
        PreferenceManager.getData<bool>(StorageKey.isLoggedIn) ?? false;

    final bool isOnboardingSeen =
        PreferenceManager.getData<bool>(StorageKey.onboarding) ?? false;

    if (!context.mounted) return;

    if (isLoggedIn) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.mainView,
            (route) => false,
      );
      return;
    }

    if (!isOnboardingSeen) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.onboardingView,
            (route) => false,
      );
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.loginView,
          (route) => false,
    );
  }
}