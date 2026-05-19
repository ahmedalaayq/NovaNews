import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nova_news/core/datasource/local/preference_manager.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';

import '../../../models/article_model.dart';

class CustomNewsTile extends StatefulWidget {
  const CustomNewsTile({super.key, required this.item});
  final ArticleModel item;

  @override
  State<CustomNewsTile> createState() => _CustomNewsTileState();
}

class _CustomNewsTileState extends State<CustomNewsTile> {
  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.item.urlToImage;

    return Container(
      margin: .symmetric(vertical: 12),
      padding: .all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: .circular(8),
      ),
      child: Row(
        children: [
          imageUrl != null && imageUrl.isNotEmpty
              ? ClipRRect(
                  borderRadius: .circular(4),
                  child: Image.network(
                    imageUrl,
                    fit: .cover,
                    width: 80,
                    height: 80,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: Theme.of(context).primaryColor,
                        child: Icon(Icons.broken_image),
                      );
                    },
                  ),
                )
              : Container(
                  width: 80,
                  height: 80,
                  color: Theme.of(context).primaryColor,
                  child: Icon(Icons.broken_image),
                ),

          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.source.name ?? "No Name",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: LightAppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),
                Text(
                  textAlign: .left,
                  widget.item.title ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateTime.tryParse(
                          widget.item.publishedAt.toString(),
                        ).toString(),
                        style: Theme.of(context).textTheme.titleSmall
                            ?.copyWith(
                              color: const Color(0xFF888888),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),

                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      onPressed: () async {
                        List<ArticleModel> bookMarkList = [];

                        final data =
                            PreferenceManager.getData<String>(
                              'bookmark',
                            );

                        if (data != null) {
                          final decoded = jsonDecode(data) as List;

                          bookMarkList = decoded
                              .map((e) => ArticleModel.fromJson(e))
                              .toList();
                        }

                        final isExist = bookMarkList.any(
                          (element) => element.url == widget.item.url,
                        );

                        if (!isExist) {
                          bookMarkList.add(widget.item);

                          final encoded = jsonEncode(
                            bookMarkList
                                .map((e) => e.toJson())
                                .toList(),
                          );

                          await PreferenceManager.setData<String>(
                            'bookmark',
                            encoded,
                          );

                          log('Bookmark Saved');
                        } else {
                          log('Already Exists');
                        }

                        setState(() {});
                      },
                      icon: const Icon(Icons.bookmark_outline),
                    ),

                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
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
