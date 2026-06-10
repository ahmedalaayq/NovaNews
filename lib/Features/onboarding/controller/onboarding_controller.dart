import 'package:flutter/material.dart';
import 'package:nova_news/Features/onboarding/models/onboarding_model.dart';
import 'package:nova_news/core/datasource/local/preference_manager.dart';
import 'package:nova_news/core/datasource/local/storage_key.dart';
import 'package:nova_news/core/mixins/safe_notify_mixin.dart';
import 'package:nova_news/core/router/app_routes.dart';

class OnboardingController with ChangeNotifier ,SafeNotifyMixin{
  late final PageController pageController;

  int currentIndex = 0;

  void init() {
    pageController = PageController();
  }

  void onPageChanged(int index) {
    currentIndex = index;
    safeNotify();
  }

  bool get isLastPage =>
      currentIndex == OnboardingModel.onboardingItems.length - 1;

  void handleNextButton(BuildContext context) async {
    if (isLastPage) {
      Navigator.pushReplacementNamed(context, AppRoutes.loginView);
      await savedPrefs();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void onDotClicked(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void skip(BuildContext context) async {
    Navigator.pushReplacementNamed(context, AppRoutes.loginView);
    await savedPrefs();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> savedPrefs() async {
    await PreferenceManager.setData(StorageKey.onboarding, true);
  }
}
