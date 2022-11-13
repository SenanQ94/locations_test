import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/loctaions_screen.dart';
import './providers/theme_provider.dart';
import '../providers/search_provider.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
      ],
      child: Consumer2<ThemeNotifier, SearchProvider>(
        child: LocationsScreen(),
        builder:
            (context, ThemeNotifier notifier, SearchProvider search, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            debugShowCheckedModeBanner: false,
            home: child,
          );
        },
      ),
    );
  }
}
