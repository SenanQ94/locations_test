import 'package:flutter/material.dart';

//provider class to controll the search text

class SearchProvider with ChangeNotifier {
  TextEditingController _searchController = TextEditingController();
  String _suchText = '';

  String get suchText => _suchText;
  TextEditingController get searchController => _searchController;

  //Set the search text on every key stroke
  onChange(String value) {
    _suchText = value;
    notifyListeners();
  }

  //clear the search controller
  clearController() {
    _searchController.clear();
    notifyListeners();
  }
}
