import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/screens/loctaions_screen.dart';
import './providers/theme_provider.dart';
import '../providers/search_provider.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // connect with the 2 Providers we have
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
        // child property to prevent th main screen from rebuilding and sending request to API when changing the Theme
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
