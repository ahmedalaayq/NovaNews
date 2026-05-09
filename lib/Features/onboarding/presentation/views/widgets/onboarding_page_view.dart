import 'package:flutter/material.dart';
import 'package:nova_news/Features/onboarding/controller/onboarding_controller.dart';
import 'package:nova_news/Features/onboarding/models/onboarding_model.dart';
import 'package:nova_news/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingController>(
      builder: (context, controller, _) {
        return PageView.builder(
          controller: controller.pageController,
          itemCount: OnboardingModel.onboardingItems.length,
          onPageChanged: controller.onPageChanged,
          itemBuilder: (context, index) {
            final item =
                OnboardingModel.onboardingItems[index];

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: controller.isLastPage
                        ? const SizedBox(height: 48)
                        : TextButton(
                            onPressed: () =>
                                controller.skip(context),
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                color:
                                    AppColors.primaryColor,
                                fontSize: 14,
                                fontWeight:
                                    FontWeight.w500,
                              ),
                            ),
                          ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: Image.asset(
                      item.image,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF4E4B66),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    item.subTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6E7191),
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        );
      },
    );
  }
}