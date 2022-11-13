import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/loctaions_screen.dart';
import 'providers/theme_provider.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        child: LocationsScreen(),
        builder: (context, ThemeNotifier notifier, child) {
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
