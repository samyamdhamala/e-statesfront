import 'package:flutter/material.dart';

// class MyThemes {
//   static final lightTheme = ThemeData(
//     primarySwatch: Colors.deepPurple,
//     appBarTheme: const AppBarTheme(color: Color(0xff7062b3)),
//   );
//   static final ThemeData darkTheme = ThemeData(
//     primarySwatch: Colors.deepPurple,
//     brightness: Brightness.dark,
//     appBarTheme: const AppBarTheme(color: Color(0xff7062b3)),
//     colorScheme: ColorScheme.dark(),
//   );
// }

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isdarkTheme = false;
  ThemeMode get currentTheme => _isdarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isdarkTheme = !_isdarkTheme;
    notifyListeners();
  }
  bool isSwitchOn() {
    return _isdarkTheme;
  }
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.deepPurple,
      appBarTheme: const AppBarTheme(color: Color(0xff7062b3)),
      bottomAppBarColor: Colors.grey[400],
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Color.fromRGBO(93, 83, 253, 1),
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        headline2: TextStyle(
          color: Color(0xfff63e3c),
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        headline3: TextStyle(
            color: Color(0xff4d3a58),
            fontSize: 22,
            fontWeight: FontWeight.w600),
        subtitle2: TextStyle(
          color: Colors.black.withOpacity(0.5),
        ),
        labelMedium:
            TextStyle(color: Color.fromRGBO(40, 32, 175, 1), fontSize: 15),
        headline5: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.3),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(),
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Color.fromARGB(255, 164, 159, 233),
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        headline2: TextStyle(
          color: Color.fromARGB(255, 240, 128, 126),
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        headline3: TextStyle(
            color: Color.fromARGB(212, 220, 201, 228),
            fontSize: 22,
            fontWeight: FontWeight.w600),
        subtitle2: TextStyle(color: Colors.white54),
        subtitle1: TextStyle(color: Colors.white54),
        labelMedium: TextStyle(fontSize: 15),
        headline5: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.3),
      ),
    );
  }
}
