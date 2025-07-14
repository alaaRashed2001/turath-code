import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferencesController {

  static const String langKey = 'lang';
  static final SharedPreferencesController _sharedPrefControllerObj =
  SharedPreferencesController._sharedPrefPrivateConstructor();

  SharedPreferencesController._sharedPrefPrivateConstructor();

  late SharedPreferences _sharedPrefLibObj;

  factory SharedPreferencesController() {
    return _sharedPrefControllerObj;
  }

  Future<void> initSharedPreferences() async {
    _sharedPrefLibObj = await SharedPreferences.getInstance();
  }


  /// Save Language
  Future<void> setLanguage(String language) async {
    await _sharedPrefLibObj.setString(langKey, language);
  }

  String get getLanguage => _sharedPrefLibObj.getString(langKey) ?? 'ar';

  /// Theme
  bool getTheme() {
    return _sharedPrefLibObj.getBool('isDark') ?? false;
  }

  void setTheme(bool value) {
    _sharedPrefLibObj.setBool('isDark', value);
  }


}

