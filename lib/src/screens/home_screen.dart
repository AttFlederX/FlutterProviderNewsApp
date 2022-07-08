import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_manager/window_manager.dart';

import '../widgets/window_buttons.dart';
import 'tabs/headlines_screen.dart';
import 'tabs/topics_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WindowListener {
  int _selectedTab = 0;
  final viewKey = GlobalKey();

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      key: viewKey,
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: DragToMoveArea(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Row(
              children: const [
                Text('News App'),
              ],
            ),
          ),
        ),
        actions: const WindowButtons(),
      ),
      pane: NavigationPane(
        displayMode: PaneDisplayMode.top,
        selected: _selectedTab,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.news),
            title: const Text('Top headlines'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.news_search),
            title: const Text('Topics'),
          ),
        ],
        onChanged: (i) => setState(() {
          _selectedTab = i;
        }),
      ),
      content: NavigationBody.builder(
        index: _selectedTab,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return const HeadlinesScreen();
            case 1:
              return const TopicsScreen();
            default:
              return const Text('aww dang');
          }
        },
      ),
    );
  }
}
