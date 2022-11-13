import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../consts/constans.dart';

//configration of Dark & Light Theme

ThemeData light = ThemeData(
  brightness: Brightness.light,
  bottomAppBarColor: KAppBarColorDark,
  iconTheme: IconThemeData(color: kIconsColorLight),
  listTileTheme: ListTileThemeData(
    iconColor: kIconsColorLight,
  ),
);

ThemeData dark = ThemeData(
  bottomAppBarColor: KAppBarColorDark,
  brightness: Brightness.dark,
  iconTheme: IconThemeData(color: kIconsColorDark),
  listTileTheme: ListTileThemeData(
    iconColor: kIconsColorDark,
  ),
);

//Provider class to switch between Themes and save the chosen value into  SharedPreferences

class ThemeNotifier with ChangeNotifier {
  bool _darkTheme = false;
  final String key = "theme";
  SharedPreferences? _prefs;
  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = false;
    _loadFromPrefs();
  }

  //change Theme
  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  // Initializing SharedPreferences for the first time
  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  // get the values saved in SharedPreferences
  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs!.getBool(key) ?? true;
    notifyListeners();
  }

  // save the values in SharedPreferences
  _saveToPrefs() async {
    await _initPrefs();
    _prefs!.setBool(key, _darkTheme);
  }
}
