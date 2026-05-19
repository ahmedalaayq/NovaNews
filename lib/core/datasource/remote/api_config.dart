import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static const String baseUrl = 'newsapi.org';
  static final String apiKey = dotenv.get('NEWS_API_KEY');
  static const String topHeadlines = 'top-headlines';
  static const String everything = 'everything';
}
