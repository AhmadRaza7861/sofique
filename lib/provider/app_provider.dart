import 'package:flutter/cupertino.dart';

class AppProvider extends ChangeNotifier {
  int _selectedIndex = 1;
  int get selectedIndex => this._selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }
}
