import 'package:flutter/material.dart';
import 'package:renvo_app/core/style/repo.dart';

class AppStyle {
  static ThemeData get theme {
    return ThemeData(
      progressIndicatorTheme: ProgressIndicatorThemeData(color: StyleRepo.blue),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: StyleRepo.white),
      ),
      primaryColor: StyleRepo.blue,
      scaffoldBackgroundColor: StyleRepo.white,
      navigationBarTheme: NavigationBarThemeData(
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: StyleRepo.green);
          }
          return IconThemeData(color: StyleRepo.grey);
        }),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(StyleRepo.blue),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: StyleRepo.grey),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: StyleRepo.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: StyleRepo.softGrey),
          borderRadius: BorderRadius.circular(20), // يمكنك تعديله حسب الرغبة
        ),
      ),
    );
  }
}
