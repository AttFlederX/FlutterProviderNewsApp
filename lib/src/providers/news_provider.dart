import 'package:flutter/foundation.dart';
import 'package:news_app_provider/src/models/news_article.dart';
import 'package:news_app_provider/src/services/news_api_service.dart';

class NewsProvider with ChangeNotifier {
  final _newsApiService = NewsApiService();

  List<NewsArticle> _topHeadlines = List.empty();
  List<NewsArticle> _queriedHeadlines = List.empty();

  List<NewsArticle> get topHeadlines => _topHeadlines;
  List<NewsArticle> get queriedHeadlines => _queriedHeadlines;

  String query = '';

  Future updateTopHeadlines() async {
    _topHeadlines = await _newsApiService.getTopHeadlinesForCountry('us');

    notifyListeners();
  }

  Future queryHeadlines() async {
    if (query.length > 3) {
      _queriedHeadlines = await _newsApiService.getNewsByQuery(query);
    }
  }

  void setQuery(String newQuery) {
    query = newQuery;

    notifyListeners();
  }
}
