
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        elevation: 2,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(fontSize: 16, color: Colors.black),
        bodyText2: TextStyle(fontSize: 14, color: Colors.black54),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ),
    );
  }
}
