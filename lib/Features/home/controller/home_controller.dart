import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nova_news/core/datasource/remote/api_config.dart';
import 'package:nova_news/core/enums/request_status_enum.dart';

import '../../../core/datasource/remote/api_service.dart';
import '../models/article_model.dart';

class HomeController with ChangeNotifier {
  void init() {
    apiService = ApiService();
    getTopHeadlines();
    getEverything();
  }

  List<ArticleModel> topHeadlineNewsList = [];
  List<ArticleModel> everythingNewsList = [];
  String? errorMessage;
  late ApiService apiService;
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
  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadlinesStatus = RequestStatusEnum.loading;

  Future<void> getTopHeadlines({String? category}) async {
    errorMessage = null;
    topHeadlinesStatus = .loading;
    notifyListeners();

    dynamic response;
    try {
      response = await apiService.get(
        endPoint: ApiConfig.topHeadlines,
        params: {"country": "us", "category": category ?? ""},
      );

      topHeadlinesStatus = RequestStatusEnum.loaded;
      topHeadlineNewsList = (response['articles'] as List<dynamic>)
          .map((e) => ArticleModel.fromJson(e))
          .toList();
    } catch (e) {
      topHeadlinesStatus = RequestStatusEnum.error;
      //todo: data loaded with error
      topHeadlinesStatus = RequestStatusEnum.loaded;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> getEverything() async {
    errorMessage = null;
    notifyListeners();

    dynamic response;
    try {
      response = await apiService.get(endPoint: ApiConfig.everything, params: {"q": "technology"});

      everythingStatus = RequestStatusEnum.loaded;
      everythingNewsList = (response['articles'] as List<dynamic>)
          .map((e) => ArticleModel.fromJson(e))
          .toList();
    } catch (e) {
      everythingStatus = RequestStatusEnum.error;
      //todo: data loaded with error
      topHeadlinesStatus = RequestStatusEnum.loaded;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void onSelectedCategory(String category) {
    selectedCategory = category;

    if (category.toLowerCase() == topNews) {
      notifyListeners();
      return;
    }

    getTopHeadlines(category: category);
    notifyListeners();
  }
}
