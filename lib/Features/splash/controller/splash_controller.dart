import 'package:flutter/material.dart';
import 'package:nova_news/core/datasource/local/preference_manager.dart';
import 'package:nova_news/core/datasource/local/storage_key.dart';
import 'package:nova_news/core/router/app_routes.dart';

class SplashController with ChangeNotifier {
  void executeNavigation(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));

    final isLoggedIn = PreferenceManager.getData<bool>(
      StorageKey.isLoggedIn,
    );
    final isOnboardingSeen = PreferenceManager.getData<bool>(
      StorageKey.onboarding,
    );

    if (!context.mounted) return;

    if (isLoggedIn == true) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.mainView,
        (route) => false,
      );
    } else if (isOnboardingSeen == true) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.loginView,
        (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.onboardingView,
        (route) => false,
      );
    }
  }
}
