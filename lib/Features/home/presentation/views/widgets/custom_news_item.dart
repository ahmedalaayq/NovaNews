import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nova_news/Features/home/models/article_model.dart';
import 'package:nova_news/core/extension/shared_extension.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';
import 'package:nova_news/core/utils/assets.dart';
import 'package:nova_news/core/widgets/custom_cached_network_image.dart';

class CustomNewsItem extends StatelessWidget {
  const CustomNewsItem({super.key, required this.model});

  final ArticleModel model;

  @override
  Widget build(BuildContext context) {
    final author = model.author ?? "No Author";
    const placeholderNetworkImage =
        'https://aideplus.com/wp-content/uploads/2017/09/image_large.png';
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomCachedNetworkImage(
              fit: .cover,
              imageUrl: model.urlToImage ?? placeholderNetworkImage,
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(model.title ?? "", maxLines: 2, overflow: TextOverflow.ellipsis),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(
                            model.urlToImage ?? placeholderNetworkImage,
                          ),
                        ),

                        const SizedBox(width: 4),

                        Text(
                          author.substring(0, min(author.length, 10)),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          model.publishedAt.formatDate(),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      AppAssets.assetsImagesBookMark,
                      colorFilter: ColorFilter.mode(LightAppColors.secondaryColor, .srcIn),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
