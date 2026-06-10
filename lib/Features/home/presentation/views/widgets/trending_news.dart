import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nova_news/Features/home/presentation/views/widgets/view_all_componenet.dart';
import 'package:nova_news/core/enums/request_status_enum.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';
import 'package:nova_news/core/utils/app_sizes.dart';
import 'package:nova_news/core/widgets/gradient_overlay.dart';
import 'package:provider/provider.dart';
import 'package:redacted/redacted.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/home_controller.dart';
import 'custom_newst_trending_list.dart';
import 'newst_appbar.dart';
import 'newst_bg_image.dart';
import 'skeletonizer_news_list.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.h(390),
      child: Stack(
        children: [
          NewstBgImage(),
          Positioned.fill(
            top: AppSizes.h(70),
            child: Column(
              children: [
                NewstAppbar(),
                SizedBox(height: AppSizes.h(4)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.w(16)),
                  child: ViewAllComponenet(title: 'Trending News', onTap: () {}),
                ),
                SizedBox(height: AppSizes.h(16)),
                Consumer<HomeController>(
                  builder: (context, controller, child) {
                    switch (controller.everythingStatus) {
                      case RequestStatusEnum.loading:
                        return SizedBox(
                          height: AppSizes.h(180),
                          child: SkeletonizerNewsList(),
                        );
                      case RequestStatusEnum.error:
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: AppSizes.w(16.0)),
                          child: Center(
                            child: Text(
                              maxLines: 2,
                              controller.errorMessage ?? "Something went wrong",
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(color: LightAppColors.whiteBgColor),
                            ),
                          ),
                        );
                      case RequestStatusEnum.loaded:
                        return SizedBox(height: AppSizes.h(180), child: CustomNewstTrendingList());
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
