class NewsArticleModel {
  final String? articleId;
  final String? link;
  final String? title;
  final String? description;
  final String? content;
  final List<String>? keywords;
  final List<String>? creator;
  final String? language;
  final List<String>? country;
  final List<String>? category;
  final String? datatype;
  final String? pubDate;
  final String? pubDateTZ;
  final String? fetchedAt;
  final String? imageUrl;
  final String? videoUrl;
  final String? sourceId;
  final String? sourceName;
  final int? sourcePriority;
  final String? sourceUrl;
  final String? sourceIcon;
  final String? sentiment;
  final String? sentimentStats;
  final String? aiTag;
  final String? aiRegion;
  final String? aiOrg;
  final String? aiSummary;
  final bool duplicate;
   bool isBookMark;

   NewsArticleModel({
    this.articleId,
    this.link,
    this.title,
    this.description,
    this.content,
    this.keywords,
    this.creator,
    this.language,
    this.country,
    this.category,
    this.datatype,
    this.pubDate,
    this.pubDateTZ,
    this.fetchedAt,
    this.imageUrl,
    this.videoUrl,
    this.sourceId,
    this.sourceName,
    this.sourcePriority,
    this.sourceUrl,
    this.sourceIcon,
    this.sentiment,
    this.sentimentStats,
    this.aiTag,
    this.aiRegion,
    this.aiOrg,
    this.aiSummary,
    this.duplicate = false,
    this.isBookMark = false,
  });

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      articleId: json['article_id'],
      link: json['link'],
      title: json['title'],
      description: json['description'],
      content: json['content'],

      keywords: (json['keywords'] as List?)?.map((e) => e.toString()).toList(),

      creator: (json['creator'] as List?)?.map((e) => e.toString()).toList(),

      language: json['language'],

      country: (json['country'] as List?)?.map((e) => e.toString()).toList(),

      category: (json['category'] as List?)?.map((e) => e.toString()).toList(),

      datatype: json['datatype'],
      pubDate: json['pubDate'],
      pubDateTZ: json['pubDateTZ'],
      fetchedAt: json['fetched_at'],
      imageUrl: json['image_url'],
      videoUrl: json['video_url'],
      sourceId: json['source_id'],
      sourceName: json['source_name'],
      sourcePriority: json['source_priority'],
      sourceUrl: json['source_url'],
      sourceIcon: json['source_icon'],
      sentiment: json['sentiment'],
      sentimentStats: json['sentiment_stats'],
      aiTag: json['ai_tag'],
      aiRegion: json['ai_region'],
      aiOrg: json['ai_org'],
      aiSummary: json['ai_summary'],
      duplicate: json['duplicate'] ?? false,
      isBookMark: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'article_id': articleId,
      'link': link,
      'title': title,
      'description': description,
      'content': content,
      'keywords': keywords,
      'creator': creator,
      'language': language,
      'country': country,
      'category': category,
      'datatype': datatype,
      'pubDate': pubDate,
      'pubDateTZ': pubDateTZ,
      'fetched_at': fetchedAt,
      'image_url': imageUrl,
      'video_url': videoUrl,
      'source_id': sourceId,
      'source_name': sourceName,
      'source_priority': sourcePriority,
      'source_url': sourceUrl,
      'source_icon': sourceIcon,
      'sentiment': sentiment,
      'sentiment_stats': sentimentStats,
      'ai_tag': aiTag,
      'ai_region': aiRegion,
      'ai_org': aiOrg,
      'ai_summary': aiSummary,
      'duplicate': duplicate,
    };
  }
}
