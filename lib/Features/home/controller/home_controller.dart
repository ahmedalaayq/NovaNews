import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nova_news/Features/home/repos/news_repository.dart';
import 'package:nova_news/core/datasource/local/preference_manager.dart';
import 'package:nova_news/core/datasource/local/storage_key.dart';
import 'package:nova_news/core/enums/request_status_enum.dart';
import 'package:nova_news/core/mixins/safe_notify_mixin.dart';

import '../models/article_model.dart';

class HomeController with ChangeNotifier,SafeNotifyMixin {
  HomeController({required this.newsRepo});
  final NewsRepository newsRepo;

  Future<void> init() async {

    loadBookmarks();

    await Future.wait([getTopHeadlines(), getEverything()]);
  }

  List<ArticleModel> topHeadlineNewsList = [];
  List<ArticleModel> everythingNewsList = [];

  List<ArticleModel> savedBookMarks = [];

  String? errorMessage;

  RequestStatusEnum topHeadlinesStatus = RequestStatusEnum.loading;

  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;

  static const String topNews = 'top news';

  static final List<String> categories = [
    'top news',
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];

  String selectedCategory = topNews;


  Future<void> getTopHeadlines({String? category}) async {
    errorMessage = null;
    topHeadlinesStatus = RequestStatusEnum.loading;
    safeNotify();

    try {
      topHeadlineNewsList = await newsRepo.getTopHeadlines(category);
      syncBookmarks();

      topHeadlinesStatus = RequestStatusEnum.loaded;
    } catch (e) {
      topHeadlinesStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }

    safeNotify();
  }

  Future<void> getEverything() async {
    everythingStatus = RequestStatusEnum.loading;
    errorMessage = null;

    safeNotify();

    try {
      everythingNewsList = await newsRepo.getEverything();

      syncBookmarks();

      everythingStatus = RequestStatusEnum.loaded;
    } catch (e) {
      everythingStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }

    safeNotify();
  }

  Future<void> onSelectedBookMark(ArticleModel article) async {
    final exists = savedBookMarks.any((e) => e.url == article.url);

    if (exists) {
      savedBookMarks.removeWhere((e) => e.url == article.url);
      article.isBookMark = false;
    } else {
      savedBookMarks.add(article);
      article.isBookMark = true;
    }

    await _saveBookmarks();

    safeNotify();
  }

  void syncBookmarks() {
    for (final article in topHeadlineNewsList) {
      article.isBookMark = savedBookMarks.any((e) => e.url == article.url);
    }

    for (final article in everythingNewsList) {
      article.isBookMark = savedBookMarks.any((e) => e.url == article.url);
    }
  }

  void loadBookmarks() {
    final data = PreferenceManager.getData<String>(StorageKey.bookmark);

    if (data == null || data.isEmpty) return;

    try {
      final decoded = jsonDecode(data) as List;

      savedBookMarks = decoded.map((e) => ArticleModel.fromJson(e)).toList();
    } catch (e) {
      savedBookMarks = [];
    }
  }

  Future<void> _saveBookmarks() async {
    final encoded = jsonEncode(savedBookMarks.map((e) => e.toJson()).toList());

    await PreferenceManager.setData<String>(StorageKey.bookmark, encoded);
  }

  void onSelectedCategory(String category) {
    selectedCategory = category;

    safeNotify();

    if (category.toLowerCase() == topNews) {
      getTopHeadlines();
    } else {
      getTopHeadlines(category: category);
    }
  }

}
