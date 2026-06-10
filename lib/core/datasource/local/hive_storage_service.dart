import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:nova_news/Features/home/models/article_model.dart';

class HiveStorageService {
  HiveStorageService._();

  static final instance = HiveStorageService._();

  late Box<ArticleModel> _articlesBox;
  late Box<ArticleModel> _bookmarksBox;

  Future<void> init() async {
    await Hive.initFlutter();

    _articlesBox = await openBox<ArticleModel>('articles');
    _bookmarksBox = await openBox<ArticleModel>('bookmarks');
  }

  Future<Box<T>> openBox<T>(String name) {
    return Hive.openBox<T>(name);
  }

  Box<ArticleModel> get articlesBox => _articlesBox;

  Box<ArticleModel> get bookmarksBox => _bookmarksBox;
}