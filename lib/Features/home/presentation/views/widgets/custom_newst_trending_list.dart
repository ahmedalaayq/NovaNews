import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nova_news/Features/home/controller/home_controller.dart';
import 'package:nova_news/core/extension/shared_extension.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';
import 'package:nova_news/core/utils/utils.dart';
import 'package:nova_news/core/widgets/gradient_overlay.dart';
import 'package:provider/provider.dart';
import 'package:redacted/redacted.dart';
import 'package:shimmer/shimmer.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: value.everythingNewsList.take(5).length,
          separatorBuilder: (_, _) => const SizedBox(width: 12),

          itemBuilder: (context, index) {
            final article = value.everythingNewsList[index];

            return ClipRRect(
              borderRadius: BorderRadius.circular(8),

              child: Stack(
                children: [
                  article.urlToImage != null
                      ? CachedNetworkImage(
                          width: 300,

                          imageUrl: article.urlToImage ?? placeholderNetworkImage,
                          errorWidget: (context, url, error) {
                            return Image.network(placeholderNetworkImage);
                          },
                          fit: .fill,
                          fadeInCurve: Curves.easeInOut,
                          height: 240,
                        ).redacted(redact: true, context: context)
                      : Image.network(placeholderNetworkImage, fit: .fill),

                  Positioned.fill(child: GradientOverlay()),

                  Positioned(
                    left: 12,
                    right: 12,
                    top: 80,

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
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Row(
                              children: [
                                article.urlToImage != null
                                    ? CircleAvatar(
                                        radius: 15,
                                        backgroundImage: NetworkImage(
                                          article.urlToImage ?? placeholderNetworkImage,
                                        ),
                                      )
                                    : Image.network(placeholderNetworkImage),
                                SizedBox(width: 4),
                                Text(
                                  article.source.name ?? "CNN News",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: LightAppColors.whiteBgColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              article.publishedAt.formatDate(),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 16,
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
