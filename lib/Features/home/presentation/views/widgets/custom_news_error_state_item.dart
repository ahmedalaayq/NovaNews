import 'package:flutter/material.dart';
import 'package:nova_news/Features/home/controller/home_controller.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';
import 'package:nova_news/core/utils/app_sizes.dart';
import 'package:provider/provider.dart';
class CustomNewsErrorStateItem extends StatelessWidget {
  const CustomNewsErrorStateItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, controller, Widget? child) {
        return SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: AppSizes.w(30),
            ),

            child: Column(
              mainAxisSize: .min,
              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [
                Container(
                  height: AppSizes.h(120),
                  width: AppSizes.w(120),

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: LightAppColors.primaryColor
                        .withOpacity(.08),
                  ),

                  child: Icon(
                    Icons.newspaper_rounded,
                    size: AppSizes.r(60),
                    color:
                    LightAppColors.primaryColor,
                  ),
                ),

                SizedBox(height: AppSizes.h(16)),

                Text(
                  controller.topHeadlineNewsList
                      .isEmpty
                      ? "No News Found"
                      : "Oops! Something went wrong",

                  textAlign: TextAlign.center,

                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                 SizedBox(height: AppSizes.h(12)),

                Text(
                  controller.topHeadlineNewsList
                      .isEmpty
                      ? "There are no articles available right now."
                      : "We couldn't load the latest news. Please try again.",

                  textAlign: TextAlign.center,

                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                    color:
                    Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),

                 SizedBox(height: AppSizes.h(30)),

                SizedBox(
                  width: AppSizes.w(170),
                  height: AppSizes.h(50),

                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await controller.getTopHeadlines();
                    },

                    icon: const Icon(
                      Icons.refresh,
                    ),

                    label: const Text(
                      "Try Again",
                    ),

                    style:
                    ElevatedButton.styleFrom(
                      elevation: 0,
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                          AppSizes.r(14),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
