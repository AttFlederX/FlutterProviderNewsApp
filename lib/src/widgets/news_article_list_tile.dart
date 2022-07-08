import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';
import 'package:news_app_provider/src/models/news_article.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsArticleListTile extends StatelessWidget {
  final NewsArticle newsArticle;
  const NewsArticleListTile(this.newsArticle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => await launchUrlString(newsArticle.url),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: FluentTheme.of(context).cardColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image
            newsArticle.imageUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      newsArticle.imageUrl,
                      width: 240,
                      cacheWidth: 240,
                    ),
                  )
                : const SizedBox(
                    width: 240,
                  ),
            const SizedBox(width: 16),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // date
                  Text(
                    '${DateFormat.yMMMd().add_jm().format(newsArticle.publishedAt.toLocal())} - ${newsArticle.source}',
                    style: FluentTheme.of(context).typography.caption,
                  ),
                  // title
                  Text(
                    newsArticle.title,
                    style: FluentTheme.of(context).typography.subtitle,
                  ),
                  const SizedBox(height: 8),
                  // description
                  Text(
                    newsArticle.description,
                    style: FluentTheme.of(context).typography.body,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
