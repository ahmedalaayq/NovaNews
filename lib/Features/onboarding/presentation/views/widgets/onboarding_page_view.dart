import 'package:flutter/material.dart';
import 'package:nova_news/Features/onboarding/controller/onboarding_controller.dart';
import 'package:nova_news/Features/onboarding/models/onboarding_model.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';
import 'package:nova_news/core/utils/app_sizes.dart';
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
            final item = OnboardingModel.onboardingItems[index];

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.w(16)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: controller.isLastPage
                        ?   SizedBox(height: AppSizes.h(48))
                        : TextButton(
                            onPressed: () => controller.skip(context),
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                color: LightAppColors.primaryColor,
                                fontSize: AppSizes.sp(14),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                  ),

                   SizedBox(height: AppSizes.h(20)),

                  Expanded(
                    child: Image.asset(
                      item.image,
                      fit: BoxFit.contain,

                    ),
                  ),

                   SizedBox(height: AppSizes.h(24)),

                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                      color: Color(0xFF4E4B66),
                      fontSize: AppSizes.sp(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    item.subTitle,
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                      fontSize: AppSizes.sp(16),
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6E7191),
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: AppSizes.h(40)),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
