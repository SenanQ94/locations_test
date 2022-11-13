import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  TextEditingController _searchController = TextEditingController();
  String _suchText = '';

  String get suchText => _suchText;
  TextEditingController get searchController => _searchController;

  onChange(String value) {
    _suchText = value;
    notifyListeners();
  }

  clearController() {
    _searchController.clear();
    notifyListeners();
  }
}
