import 'package:flutter/material.dart';
import 'package:login/pages/home_page.dart';
// import 'package:login/pages/home_page.dart';
import 'package:login/pages/login_page.dart';
import 'package:login/pages/splash_screen.dart';

void main() {
  runApp(MaterialApp(
    themeMode: ThemeMode.light,
    theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(color: Color(0xff7062b3))),
    debugShowCheckedModeBanner: false,
    initialRoute: 'splashscreen',
    routes: {
      'login': (context) => const LoginPage(),
      'home': (context) => HomePage(),
      'splashscreen': (context) => SplashScreen(),
    },
  ));
}
