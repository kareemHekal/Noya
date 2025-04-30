import 'package:flutter/material.dart';
import 'package:noya_app/core/utils/colors_manager.dart';

class MyTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: const AppBarTheme(color: Colors.white),
      cardColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: ColorManager.white70),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorManager.white70),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorManager.white70),
        ),
        focusColor: ColorManager.white70,
        floatingLabelStyle: TextStyle(color: ColorManager.white70),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        selectedItemColor: ColorManager.oliveGreen,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.black),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
      ),
    );
  }
}
