import 'package:flutter/material.dart';
import 'package:nova_news/Features/home/controller/home_controller.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';
import 'package:provider/provider.dart';
class CustomNewsErrorStateItem extends StatelessWidget {
  const CustomNewsErrorStateItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, controller, Widget? child) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),

            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [
                Container(
                  height: 120,
                  width: 120,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: LightAppColors.primaryColor
                        .withOpacity(.08),
                  ),

                  child: Icon(
                    Icons.newspaper_rounded,
                    size: 60,
                    color:
                    LightAppColors.primaryColor,
                  ),
                ),

                const SizedBox(height: 16),

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

                const SizedBox(height: 12),

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

                const SizedBox(height: 30),

                SizedBox(
                  width: 170,
                  height: 50,

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
                          14,
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
