import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static const String baseUrl = 'newsapi.org';
  static const String newsBaseUrl = 'newsdata.io';
  static final String apiKey = dotenv.get('NEWS_API_KEY');
  static final String newsDataApiKey = dotenv.get('NEWS_DATA_API_KEY');
  static const String topHeadlines = 'top-headlines';
  static const String everything = 'everything';
  static const String latest = 'latest';
}
