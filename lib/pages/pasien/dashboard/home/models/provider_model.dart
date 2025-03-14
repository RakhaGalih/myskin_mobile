import 'package:flutter/material.dart';

class ProviderModel extends ChangeNotifier {
  int _selectedNavBar = 0;
  get selectedNavBar => _selectedNavBar;
  void onNavBarTapped(int index) {
    _selectedNavBar = index;
    notifyListeners();
  }
}
