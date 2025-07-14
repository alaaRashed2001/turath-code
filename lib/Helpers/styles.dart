// import 'dart:ui';
// import 'package:flutter/material.dart';
//
// class AppStyles {
//   static BoxDecoration getContainerDecoration(bool isDark) {
//     return isDark
//         ? BoxDecoration(
//       color: Colors.white.withOpacity(0.1),
//       borderRadius: BorderRadius.circular(20),
//     )
//         : BoxDecoration(
//       color: Colors.grey[200],
//       borderRadius: BorderRadius.circular(20),
//     );
//   }
//
//   static TextStyle getTextStyle(bool isDark) {
//     return TextStyle(
//       color: isDark ? Colors.white : Colors.black,
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//     );
//   }
// }
import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData({required bool isDarkTheme, required BuildContext context}) {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: isDarkTheme ? const Color(0xFF1E1E1E) : Colors.white,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: isDarkTheme ? Colors.blueGrey : Colors.deepOrange,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}