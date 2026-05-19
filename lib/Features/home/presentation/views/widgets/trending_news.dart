import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nova_news/Features/home/presentation/views/widgets/view_all_componenet.dart';
import 'package:nova_news/core/enums/request_status_enum.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import 'custom_newst_trending_list.dart';
import 'newst_appbar.dart';
import 'newst_bg_image.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 390,
      child: Stack(
        children: [
          NewstBgImage(),
          Positioned.fill(
            top: 70,
            child: Column(
              children: [
                NewstAppbar(),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: ViewAllComponenet(
                    title: 'Trending News',
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 16),
                Consumer<HomeController>(
                  builder: (context, controller, child) {
                    switch (controller.everythingStatus) {
                      case RequestStatusEnum.loading:
                        return Center(
                          child:
                              LoadingAnimationWidget.staggeredDotsWave(
                                size: 25,
                                color: LightAppColors.whitebgColor,
                              ),
                        );
                      case RequestStatusEnum.error:
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: Center(
                            child: Text(
                              maxLines: 2,
                              controller.errorMessage!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color:
                                        LightAppColors.whitebgColor,
                                  ),
                            ),
                          ),
                        );
                      case RequestStatusEnum.loaded:
                        return SizedBox(
                          height: 180,
                          child: CustomNewstTrendingList(),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
