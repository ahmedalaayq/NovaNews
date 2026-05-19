import 'package:flutter/material.dart';
import 'package:nova_news/Features/onboarding/controller/onboarding_controller.dart';
import 'package:provider/provider.dart';

import 'widgets/onboarding_view_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingController()..init(),
      child: Scaffold(
        extendBody: true,
        backgroundColor: const Color(0xFFF5F5F5),
        body: const SafeArea(child: OnboardingViewBody()),
      ),
    );
  }
}
