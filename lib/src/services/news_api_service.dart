import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:news_app_provider/src/models/news_article.dart';

class NewsApiService {
  static const _newsApiBaseUrl = 'https://newsapi.org';
  static const _newsApiKey = 'changeme';

  final _client = Client();
  final _defaultHeaders = {
    'X-Api-Key': _newsApiKey,
  };

  Future<List<NewsArticle>> getTopHeadlinesForCountry(
      String countryCode) async {
    var url =
        Uri.parse('$_newsApiBaseUrl/v2/top-headlines?country=$countryCode');

    var response = await _client.get(url, headers: _defaultHeaders);

    if (response.statusCode == HttpStatus.ok) {
      var parsedJson = jsonDecode(response.body);
      var articles = parsedJson['articles'] as List<dynamic>;

      return articles.map((ar) => NewsArticle.fromJson(ar)).toList();
    } else {
      throw HttpException('Request failed: ${response.statusCode}', uri: url);
    }
  }

  Future<List<NewsArticle>> getNewsByQuery(String query) async {
    var urlQuery = Uri.encodeFull(query);
    var url = Uri.parse('$_newsApiBaseUrl/v2/everything?q=$urlQuery');

    var response = await _client.get(url, headers: _defaultHeaders);

    if (response.statusCode == HttpStatus.ok) {
      var parsedJson = jsonDecode(response.body);
      var articles = parsedJson['articles'] as List<dynamic>;

      return articles.map((ar) => NewsArticle.fromJson(ar)).toList();
    } else {
      throw HttpException('Request failed: ${response.statusCode}', uri: url);
    }
  }
}
