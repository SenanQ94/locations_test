import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constans.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  bottomAppBarColor: KAppBarColorDark,
  listTileTheme: ListTileThemeData(
    iconColor: kIconsColorLight,
  ),
  iconTheme: IconThemeData(color: kIconsColorLight),
);

ThemeData dark = ThemeData(
  bottomAppBarColor: KAppBarColorDark,
  brightness: Brightness.dark,
  iconTheme: IconThemeData(color: kIconsColorDark),
);

class ThemeNotifier with ChangeNotifier {
  bool _darkTheme = false;
  final String key = "theme";
  SharedPreferences? _prefs;
  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = false;
    _loadFromPrefs();
  }
  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs!.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs!.setBool(key, _darkTheme);
  }
}
