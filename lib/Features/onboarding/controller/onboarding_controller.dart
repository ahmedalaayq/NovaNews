import 'package:flutter/material.dart';
import 'package:nova_news/Features/onboarding/models/onboarding_model.dart';
import 'package:nova_news/core/router/app_routes.dart';

class OnboardingController with ChangeNotifier {
  late final PageController pageController;

  int currentIndex = 0;

  void init() {
    pageController = PageController();
  }

  void onPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  bool get isLastPage =>
      currentIndex == OnboardingModel.onboardingItems.length - 1;

  void handleNextButton(BuildContext context) {
    if (isLastPage) {
      Navigator.pushReplacementNamed(context, AppRoutes.homeView);
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

  void skip(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.homeView);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
