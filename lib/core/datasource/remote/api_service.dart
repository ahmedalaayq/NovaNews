import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:nova_news/core/datasource/remote/api_config.dart';

class ApiService {
  static final _instance = ApiService._internal();

  ApiService._internal();

  factory ApiService() => _instance;

  Future<dynamic> get({required String endPoint, Map<String, dynamic>? params}) async {
    try {
      var url = Uri.https(ApiConfig.baseUrl, 'v2/$endPoint', {
        "apiKey": ApiConfig.apiKey,
        ...?params,
      });
      log('BaseUrl: $url');

      http.Response response = await http.get(url);
      return await jsonDecode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
