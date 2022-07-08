class NewsArticle {
  late final String source;
  late final String imageUrl;
  late final String title;
  late final String description;
  late final DateTime publishedAt;
  late final String url;

  NewsArticle.fromJson(Map<String, dynamic> parsedJson)
      : source = parsedJson['source']['name'] ?? '',
        imageUrl = parsedJson['urlToImage'] ?? '',
        title = parsedJson['title'] ?? '',
        description = parsedJson['description'] ?? '',
        publishedAt = DateTime.parse(parsedJson['publishedAt']),
        url = parsedJson['url'];
}
