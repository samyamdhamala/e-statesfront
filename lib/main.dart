import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login/pages/add_new_property_page.dart';
import 'package:login/pages/common/common/home_page.dart';
import 'package:login/pages/common/common/login_page.dart';
import 'package:login/pages/common/common/splash_screen.dart';
import 'package:login/pages/display_for_own_property/own_property_listings.dart';
import 'package:login/pages/widgets/search_location_page.dart';
import 'package:login/provider/theme_provider.dart';
import 'package:lottie/lottie.dart';
import 'dart:ui' as ui;

void main() {
  RenderErrorBox.backgroundColor = Colors.transparent;
  RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: currentTheme.currentTheme,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        backgroundColor: Color.fromARGB(255, 129, 122, 231),
        splash: Container(
          child:
              Lottie.asset("assets/animations/splashscreen.json", height: 800),
        ),
        duration: 1000,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: HomePage(),
      ),

      // initialRoute: '/login',
      routes: {
        "/login": (context) => const LoginPage(),
        "/home": (context) => HomePage(),
        "/splashscreen": (context) => SplashScreen(),
        "/postpage": (context) => AddProperty(),
        "/ownproperty": (context) => OwnPropertyListings(),
        "/search": (ctx) => SearchLocationPage(),
      },
    );
  }
}

class Bloc {
  final _themeController = StreamController<bool>();
  get changeTheme => _themeController.sink.add;
  get switchDarkTheme => _themeController.stream;
}

final bloc = Bloc();
