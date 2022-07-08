import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import 'providers/news_provider.dart';
import 'screens/home_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: FluentApp(
        title: 'NewsAppProvider',
        home: const HomeScreen(),
        theme: ThemeData.dark(),
      ),
    );
  }
}
