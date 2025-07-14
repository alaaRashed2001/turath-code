import 'package:flutter/material.dart';
import '../Shared_Preferences/shared_prefrences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeProvider() {
    _isDarkTheme = SharedPreferencesController().getTheme();
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    SharedPreferencesController().setTheme(_isDarkTheme);
    notifyListeners();
  }
}