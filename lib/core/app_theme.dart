import 'package:flutter/material.dart';
import 'package:noya_app/core/utils/colors_manager.dart';

class MyTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: ColorManager.white,
      appBarTheme: const AppBarTheme(color: ColorManager.white),
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
          color: ColorManager.oliveGreen,
          fontWeight: FontWeight.bold,
        ),
        selectedItemColor: ColorManager.oliveGreen,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: ColorManager.oliveGreen),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ColorManager.white, // Set your desired background color
        modalBackgroundColor: ColorManager.white, // Background color for modal bottom sheets
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        elevation: 10, // Add elevation for shadow effect
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ColorManager.deepCharcoalWithGreenHint,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorManager.deepCharcoalWithGreenHint,
      ),
      cardColor: ColorManager.darkTaupe,
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: ColorManager.softOlive),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorManager.softOlive),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorManager.mutedSageGreen),
        ),
        focusColor: ColorManager.mutedSageGreen,
        floatingLabelStyle: TextStyle(color: ColorManager.mutedSageGreen),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(
          color: ColorManager.mutedSageGreen,
          fontWeight: FontWeight.bold,
        ),
        selectedItemColor: ColorManager.mutedSageGreen,
        unselectedItemColor: ColorManager.softOlive,
        backgroundColor: ColorManager.darkTaupe,
        selectedIconTheme: IconThemeData(color: ColorManager.mutedSageGreen),
        unselectedIconTheme: IconThemeData(color: ColorManager.softOlive),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ColorManager.darkTaupe, // Set your desired background color for dark theme
        modalBackgroundColor: ColorManager.darkTaupe, // Background color for modal bottom sheets
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        elevation: 10, // Add elevation for shadow effect
      ),
    );
  }
}
