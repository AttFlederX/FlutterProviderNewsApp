import 'package:fluent_ui/fluent_ui.dart';
import 'package:news_app_provider/src/providers/news_provider.dart';
import 'package:news_app_provider/src/widgets/news_article_list_tile.dart';
import 'package:provider/provider.dart';

class HeadlinesScreen extends StatelessWidget {
  const HeadlinesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var newsProvider = context.read<NewsProvider>();

    return FutureBuilder(
      future: newsProvider.updateTopHeadlines(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: ProgressRing());
        }
        if (!snapshot.hasError) {
          return ListView.builder(
            itemCount: newsProvider.topHeadlines.length,
            itemBuilder: (context, index) =>
                NewsArticleListTile(newsProvider.topHeadlines[index]),
          );
        } else {
          return Center(
            child: Text('Failed to load data: ${snapshot.error!}'),
          );
        }
      },
    );
  }
}
