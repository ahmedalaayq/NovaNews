import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'source_model.dart';

@HiveType(typeId: 0)
class ArticleModel extends HiveObject {
  ArticleModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    this.isBookMark = false,
  });

  @HiveField(0)
  final Source source;
  @HiveField(1)
  final String? author;
  @HiveField(2)
  final String? title;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final String url;
  @HiveField(5)
  final String? urlToImage;
  @HiveField(6)
  final DateTime publishedAt;
  @HiveField(7)
  final String? content;
  @HiveField(8)
  bool isBookMark;

  Map<String, dynamic> toJson() {
    return {
      'source': source.toJson(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
    };
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      source: Source.fromJson(json['source'] ?? {}),

      author: json['author'],

      title: json['title']?.toString(),

      description: json['description']?.toString(),

      url: json['url']?.toString() ?? "",

      urlToImage: json['urlToImage']?.toString(),

      publishedAt: DateTime.tryParse(json['publishedAt']?.toString() ?? "") ?? DateTime.now(),

      content: json['content']?.toString(),
      isBookMark: false,
    );
  }
}
