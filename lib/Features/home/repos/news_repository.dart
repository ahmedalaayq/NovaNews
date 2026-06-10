import 'package:nova_news/Features/home/models/news_data_api/news_article_model.dart';
import 'package:nova_news/core/datasource/remote/api_config.dart';
import 'package:nova_news/core/datasource/remote/api_service.dart';

import '../models/article_model.dart';

abstract class BaseNewsRepository {
  Future<dynamic> getTopHeadlines(String? category);

  Future<dynamic> getEverything({String? query = 'technology'});

  Future<dynamic> getLatestNews(String? category);
}

class NewsRepository extends BaseNewsRepository {
  final ApiService apiService;

  NewsRepository({required this.apiService});

  @override
  Future<dynamic> getTopHeadlines(String? category) async {
    final response = await apiService.get(
      endPoint: ApiConfig.topHeadlines,
      params: {"country": "us", if (category != null && category.isNotEmpty) "category": category},
    );

    return (response['articles'] as List).map((e) => ArticleModel.fromJson(e)).toList();
  }

  @override
  Future<dynamic> getLatestNews(String? category) async {
    try {
      final response = await apiService.get(
        endPoint: ApiConfig.latest,
        params: {
          "country": "eg",
          if (category != null && category.isNotEmpty) "category": category,
        },
      );
      return (response['results'] as List).map((e) => NewsArticleModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<dynamic> getEverything({String? query = 'technology'}) async {
    try {
      final response = await apiService.get(endPoint: ApiConfig.everything, params: {"q": query});

      return (response['articles'] as List).map((e) => ArticleModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
