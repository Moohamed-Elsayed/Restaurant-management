import 'package:flutter/cupertino.dart';

class NameCategory with ChangeNotifier {
  String _nameCategory;

  String get currentNameCategory => _nameCategory;

  void setNameCategory(String nameCategory) {
    _nameCategory = nameCategory;
    notifyListeners();
  }
}
