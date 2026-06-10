import 'package:flutter/material.dart';
import 'package:nova_news/Features/home/controller/home_controller.dart';
import 'package:nova_news/Features/home/models/article_model.dart';
import 'package:nova_news/core/extension/shared_extension.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';
import 'package:nova_news/core/utils/app_sizes.dart';
import 'package:provider/provider.dart';
class BookMarkViewBody extends StatelessWidget {
  const BookMarkViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Consumer<HomeController>(
      builder: (context, controller, child) {
        if (controller.savedBookMarks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Icon(Icons.bookmark_border_rounded, size: AppSizes.r(80), color: LightAppColors.primaryColor),

                const SizedBox(height: 16),

                Text(
                  'No Bookmarks Yet',
                  style: TextStyle(fontSize: AppSizes.sp(20), fontWeight: FontWeight.bold),
                ),

                SizedBox(height: AppSizes.h(8)),

                Text(
                  'Saved articles will appear here',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(AppSizes.w(16)),

          itemCount: controller.savedBookMarks.length,

          separatorBuilder: (_, _) => SizedBox(height: AppSizes.h(12)),

          itemBuilder: (context, index) {
            final ArticleModel item = controller.savedBookMarks[index];

            return Container(
              padding: EdgeInsets.all(AppSizes.w(12)),

              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,

                borderRadius: BorderRadius.circular(AppSizes.r(16)),
              ),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.r(12)),

                    child: item.urlToImage != null && item.urlToImage!.isNotEmpty
                        ? Image.network(
                      item.urlToImage!,

                      width: AppSizes.w(110),

                      height: AppSizes.h(110),

                      fit: BoxFit.cover,

                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: AppSizes.w(110),

                          height: AppSizes.h(110),

                          color: LightAppColors.primaryColor,

                          child: const Icon(Icons.broken_image, color: Colors.white),
                        );
                      },
                    )
                        : Container(
                      width: AppSizes.w(110),

                      height: AppSizes.h(110),

                      color: LightAppColors.primaryColor,

                      child: const Icon(Icons.image_not_supported, color: Colors.white),
                    ),
                  ),

                   SizedBox(width: AppSizes.w(12)),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          item.source.name ?? 'Unknown source',

                          maxLines: 1,

                          overflow: TextOverflow.ellipsis,

                          style: TextStyle(
                            color: LightAppColors.primaryColor,

                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: AppSizes.h(8)),

                        Text(
                          item.title ?? 'No title',

                          maxLines: 3,

                          overflow: TextOverflow.ellipsis,

                          style: TextStyle(fontSize: AppSizes.sp(16), fontWeight: FontWeight.bold),
                        ),

                         SizedBox(height: AppSizes.h(8)),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.publishedAt.formatDate(),

                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),

                            IconButton(
                              onPressed: () async {

                                if (!context.mounted) {
                                  return;
                                }

                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(const SnackBar(content: Text('Bookmark removed')));
                              },

                              icon: const Icon(
                                Icons.delete_outline,

                                color: LightAppColors.primaryColor,
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
