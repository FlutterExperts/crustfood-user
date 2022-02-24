import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _selectTheme;

  ThemeData light = ThemeData.light().copyWith(
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
      dialogBackgroundColor: Colors.white,
      dialogTheme: const DialogTheme(
          titleTextStyle: TextStyle(
        color: Colors.black,
      )),
      accentColor: const Color(0xff212226),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(color: Colors.white),
      textTheme: const TextTheme(
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black),
      ),
      cardTheme: const CardTheme(
        color: Colors.white,
      ));

  ThemeData dark = ThemeData.dark().copyWith(
    dialogBackgroundColor: const Color(0xff212226),
    dialogTheme: const DialogTheme(
      titleTextStyle: TextStyle(color: Colors.white),
    ),

    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Colors.black12),

    scaffoldBackgroundColor: const Color(0xff121417),
    appBarTheme: const AppBarTheme(
      color: const Color(0xff121417),
    ),
    cardTheme: const CardTheme(color: const Color(0xff212226)),

    accentColor: const Color(0xff212226),

    textTheme: const TextTheme(
      bodyText1: const TextStyle(color: Colors.white),
    ),

    // primaryColor: Color(0xff212429),
  );

  ThemeProvider({bool isDarkMode}) {
    try {
      if (isDarkMode == null) {
        _selectTheme = light;
      } else {
        _selectTheme = isDarkMode ? dark : light;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> swapTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (_selectTheme == dark) {
      _selectTheme = light;
      preferences.setBool("isDarkTheme", false);
    } else {
      _selectTheme = dark;
      preferences.setBool("isDarkTheme", true);
    }
    notifyListeners();
  }

  ThemeData get getTheme => _selectTheme;
}
