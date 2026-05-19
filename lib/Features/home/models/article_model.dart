import 'source_model.dart';

class ArticleModel {
  ArticleModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  final Source source;
  final String? author;
  final String? title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;

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

      publishedAt:
          DateTime.tryParse(json['publishedAt']?.toString() ?? "") ??
          DateTime.now(),

      content: json['content']?.toString(),
    );
  }
}
