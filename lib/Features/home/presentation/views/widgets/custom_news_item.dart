import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nova_news/Features/home/controller/home_controller.dart';
import 'package:nova_news/Features/home/models/article_model.dart';
import 'package:nova_news/core/extension/shared_extension.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';
import 'package:nova_news/core/utils/app_sizes.dart';
import 'package:nova_news/core/utils/assets.dart';
import 'package:nova_news/core/widgets/custom_cached_network_image.dart';
import 'package:nova_news/core/widgets/custom_svg_picture.dart';
import 'package:provider/provider.dart';

class CustomNewsItem extends StatelessWidget {
  const CustomNewsItem({super.key, required this.model, required this.index});

  final ArticleModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    final author = model.author ?? "No Author";
    const placeholderNetworkImage =
        'https://aideplus.com/wp-content/uploads/2017/09/image_large.png';
    return Padding(
      padding: EdgeInsets.all(AppSizes.w(16)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.r(8)),
            child: CustomCachedNetworkImage(
              width: AppSizes.w(150),
              height: AppSizes.h(80),
              fit: .cover,
              imageUrl: model.urlToImage ?? placeholderNetworkImage,
            ),
          ),

          SizedBox(width: AppSizes.w(8)),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  style: TextStyle(fontSize: AppSizes.sp(14), fontWeight: .w400),
                  model.title ?? "",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: AppSizes.h(8)),

                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: AppSizes.r(12),
                          backgroundImage: NetworkImage(
                            model.urlToImage ?? placeholderNetworkImage,
                          ),
                        ),

                        SizedBox(width: AppSizes.w(4)),

                        FittedBox(
                          child: Text(
                            style: TextStyle(
                              fontSize: AppSizes.sp(12),
                              fontWeight: FontWeight.w400,
                            ),
                            author.substring(0, min(author.length, 10)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(width: AppSizes.w(8)),
                        FittedBox(
                          child: Text(
                            model.publishedAt.formatDate(),
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(fontSize: AppSizes.sp(12)),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<HomeController>().onSelectedBookMark(model);
                      },

                      child: CustomSvgPicture.withColor(
                        path: AppAssets.assetsImagesBookMark,
                        width: AppSizes.w(20),
                        height: AppSizes.h(20),
                        color: (model.isBookMark == true)
                            ? LightAppColors.primaryColor
                            : LightAppColors.secondaryColor,
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
  }
}
