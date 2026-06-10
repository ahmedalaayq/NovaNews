import 'package:flutter/material.dart';
import 'package:nova_news/Features/onboarding/controller/onboarding_controller.dart';
import 'package:nova_news/Features/onboarding/models/onboarding_model.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';
import 'package:nova_news/core/utils/app_sizes.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_page_view.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<OnboardingController>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Column(
        children: [
          const Expanded(child: OnboardingPageView()),

          SizedBox(height: AppSizes.h(24)),

          SmoothPageIndicator(
            controller: controller.pageController,
            count: OnboardingModel.onboardingItems.length,
            onDotClicked: controller.onDotClicked,
            effect: WormEffect(
              dotColor: const Color(0xFFD3D3D3),
              activeDotColor: LightAppColors.primaryColor,
              dotHeight: AppSizes.h(10),
              dotWidth: AppSizes.w(10),
            ),
          ),

           SizedBox(height: AppSizes.h(32)),

          Consumer<OnboardingController>(
            builder:
                (
                  BuildContext context,
                  OnboardingController value,
                  Widget? child,
                ) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: LightAppColors.primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () =>
                        controller.handleNextButton(context),
                    child: Text(
                      value.isLastPage ? 'Get Started' : 'Next',
                      style:  TextStyle(
                        fontSize: AppSizes.sp(16),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
