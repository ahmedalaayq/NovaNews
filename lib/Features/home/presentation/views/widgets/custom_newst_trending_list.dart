import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nova_news/Features/home/controller/home_controller.dart';
import 'package:nova_news/core/extension/shared_extension.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';
import 'package:nova_news/core/utils/utils.dart';
import 'package:nova_news/core/widgets/custom_cached_network_image.dart';
import 'package:nova_news/core/widgets/gradient_overlay.dart';
import 'package:provider/provider.dart';
import 'package:redacted/redacted.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/utils/app_sizes.dart';

class CustomNewstTrendingList extends StatelessWidget {
  const CustomNewstTrendingList({super.key});

  @override
  Widget build(BuildContext context) {
    final placeholderNetworkImage =
        'https://aideplus.com/wp-content/uploads/2017/09/image_large.png';
    return Consumer<HomeController>(
      builder: (BuildContext context, value, Widget? child) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: AppSizes.w(16)),
          scrollDirection: Axis.horizontal,
          itemCount: value.everythingNewsList.take(5).length,
          separatorBuilder: (_, _) => SizedBox(width: AppSizes.w(12)),

          itemBuilder: (context, index) {
            final article = value.everythingNewsList[index];

            return ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.r(8)),

              child: Stack(
                children: [
                  article.urlToImage != null
                      ? CustomCachedNetworkImage(
                          width: AppSizes.w(300),
                          fit: .contain,
                          imageUrl: article.urlToImage ?? placeholderNetworkImage,
                          height: AppSizes.h(240),
                        ).redacted(redact: true, context: context)
                      : Container(
                          width: AppSizes.w(300),
                          height: AppSizes.h(240),
                          decoration: BoxDecoration(color: Colors.grey),
                        ),

                  Positioned.fill(child: GradientOverlay()),

                  Positioned(
                    left: AppSizes.w(12),
                    right: AppSizes.w(12),
                    top: AppSizes.h(80),

                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          article.title ?? "",

                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: .start,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: AppSizes.h(12)),
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Row(
                              children: [
                                article.urlToImage != null
                                    ? CircleAvatar(
                                        radius: AppSizes.r(15),
                                        backgroundImage: NetworkImage(
                                          article.urlToImage ?? placeholderNetworkImage,
                                        ),
                                      )
                                    : Image.network(placeholderNetworkImage),
                                SizedBox(width: AppSizes.w(4)),
                                Text(
                                  article.source.name ?? "CNN News",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: LightAppColors.whiteBgColor,
                                    fontSize: AppSizes.sp(12),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              article.publishedAt.formatDate(),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: AppSizes.sp(16),
                                fontWeight: .bold,
                                color: LightAppColors.whiteBgColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
