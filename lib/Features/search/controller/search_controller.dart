import 'package:flutter/material.dart';
import 'package:nova_news/Features/home/models/article_model.dart';
import 'package:nova_news/Features/home/repos/news_repository.dart';
import 'package:nova_news/core/mixins/safe_notify_mixin.dart';

class SearchController with ChangeNotifier, SafeNotifyMixin {
  SearchController(this.baseNewsRepository) {
    searchController.addListener(() {
      safeNotify();
    });
  }

  final BaseNewsRepository baseNewsRepository;

  final TextEditingController searchController = TextEditingController();

  List<ArticleModel> everythingNews = [];

  void searchNews() async {
    everythingNews = await baseNewsRepository.getEverything(query: searchController.text.trim());
    safeNotify();
  }

  void clearFields() {
    searchController.clear();
    everythingNews.clear();
    safeNotify();
  }

  // search query api

  // request
}
