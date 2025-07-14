
import 'package:echocode/Shared_Preferences/shared_prefrences.dart';
import 'package:flutter/material.dart';

class LangProvider with ChangeNotifier {
  String _lang = 'ar';
  final SharedPreferencesController _sharedPreferencesController =
      SharedPreferencesController();

  String get lang => _lang;

  LangProvider() {
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    await _sharedPreferencesController.initSharedPreferences();
    _lang = _sharedPreferencesController.getLanguage;
    notifyListeners();
  }

  Future<void> changeLanguage() async {
    _lang = (_lang == 'ar') ? 'en' : 'ar';
    await _sharedPreferencesController.setLanguage(_lang);
    notifyListeners();
  }
}
