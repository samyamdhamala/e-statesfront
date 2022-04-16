import 'package:flutter/material.dart';
import 'package:login/pages/common/common/home_page.dart';
import 'package:login/pages/common/common/login_page.dart';
import '../../../token_shared_preferences.dart';

// import 'features/register/presentation/screens/register_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool tokenOrNot = false;
  @override
  void initState() {
    super.initState();
    _checkTokenValue();
    _navigateToLogin();
  }

  _checkTokenValue() async {
    tokenOrNot = await TokenSharedPrefernces.instance.containsToken("token");
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => tokenOrNot == true ? HomePage() : LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Image(image: AssetImage('assets/images/logo.png'))),
    );
  }
}
