import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nova_news/Features/home/models/article_model.dart';
import 'package:nova_news/core/datasource/local/preference_manager.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  List<ArticleModel> bookmarks = [];

  @override
  void initState() {
    super.initState();
    loadBookmarks();
  }

  void loadBookmarks() {
    final data = PreferenceManager.getData<String>('bookmark');

    if (data != null) {
      final decoded = jsonDecode(data) as List;

      bookmarks = decoded
          .map((e) => ArticleModel.fromJson(e))
          .toList();
    }

    setState(() {});
  }

  void removeBookmark(ArticleModel item) async {
    bookmarks.removeWhere((element) => element.url == item.url);

    final encoded = jsonEncode(
      bookmarks.map((e) => e.toJson()).toList(),
    );

    await PreferenceManager.setData<String>('bookmark', encoded);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Bookmarks',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: bookmarks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border_rounded,
                    size: 80,
                    color: LightAppColors.primaryColor,
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'No Bookmarks Yet',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Saved articles will appear here',
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: bookmarks.length,

              separatorBuilder: (context, index) =>
                  const SizedBox(height: 12),

              itemBuilder: (context, index) {
                final item = bookmarks[index];

                return Container(
                  padding: const EdgeInsets.all(12),

                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),

                        child:
                            item.urlToImage != null &&
                                item.urlToImage!.isNotEmpty
                            ? Image.network(
                                item.urlToImage!,
                                width: 110,
                                height: 110,
                                fit: BoxFit.cover,

                                errorBuilder:
                                    (context, error, stackTrace) {
                                      return Container(
                                        width: 110,
                                        height: 110,
                                        color: LightAppColors
                                            .primaryColor,

                                        child: const Icon(
                                          Icons.broken_image,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      );
                                    },
                              )
                            : Container(
                                width: 110,
                                height: 110,
                                color: LightAppColors.primaryColor,

                                child: const Icon(
                                  Icons.broken_image,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [
                              Text(
                                item.source.name ?? 'Unknown Source',

                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,

                                style: TextStyle(
                                  color: LightAppColors.primaryColor,

                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Expanded(
                                child: Text(
                                  item.title ?? 'No Title',

                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,

                                  style: const TextStyle(
                                    color: Colors.white,

                                    fontSize: 16,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${item.publishedAt.day}/${item.publishedAt.month}/${item.publishedAt.year}',

                                      style: const TextStyle(
                                        color: Colors.grey,

                                        fontSize: 12,
                                      ),
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: () {
                                      removeBookmark(item);
                                    },

                                    icon: const Icon(
                                      Icons.delete,
                                      color:
                                          LightAppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
