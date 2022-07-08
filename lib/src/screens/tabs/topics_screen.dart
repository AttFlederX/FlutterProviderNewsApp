import 'package:fluent_ui/fluent_ui.dart';
import 'package:news_app_provider/src/providers/news_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/news_article_list_tile.dart';

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  final _autoSuggestBox = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<NewsProvider>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextBox(
            controller: _autoSuggestBox,
            onSubmitted: (query) async =>
                await _onQuerySubmitted(context, query),
            placeholder: 'Enter a news topic',
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: provider.queryHeadlines(),
            builder: (_, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: ProgressRing());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Failed to load data: ${snapshot.error!}'),
                );
              }

              return ListView.builder(
                itemCount: provider.queriedHeadlines.length,
                itemBuilder: (_, index) =>
                    NewsArticleListTile(provider.queriedHeadlines[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Future _onQuerySubmitted(BuildContext context, String query) async {
    context.read<NewsProvider>().setQuery(query);
  }
}
