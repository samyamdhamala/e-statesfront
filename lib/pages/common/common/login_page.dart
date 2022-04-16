import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/login_feature/login_post_method.dart';
import 'package:login/pages/common/common/home_page.dart';
import 'package:login/pages/common/common/register_page.dart';
import 'package:login/property_feature/get_all_property.dart';
import 'package:login/token_shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<LoginPage> {
  void initState() {
    super.initState();
    getData();
  }

  Future<dynamic> getData() async {
    getterData = await GetAllProperty.getAllPropertyInit();
    return getterData;
  }

  late Map<String, dynamic> getterData;
  final _signUpFormKey = GlobalKey<FormState>();
  bool _obscureText = true;
  late String email = '';
  late String password = '';
  late Map<String, dynamic> data;
  Map<String, dynamic> user = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/loginpeople.png'),
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.topRight,
                        ),
                      ),
                      height: 270,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15, top: 150),
                      child: Text(
                        'Already\nHave\nAn\nAccount?',
                        style: GoogleFonts.lato(
                            color: Color.fromRGBO(48, 48, 48, 0.74),
                            fontSize: 34,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Form(
                key: _signUpFormKey,
                child: Container(
                  padding: EdgeInsets.only(left: 55, right: 75),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email',
                          style: Theme.of(context).textTheme.labelMedium),
                      TextFormField(
                        onSaved: (value) {
                          email = value.toString();
                        },
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "Pleaser enter your email"),
                          EmailValidator(
                              errorText: "Please enter a valid email"),
                        ]),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'example@mail.com',
                          // labelText: 'Email',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Password',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          password = value.toString();
                        },
                        validator: RequiredValidator(
                            errorText: "Please enter your password!"),
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(131, 123, 255, 1),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () async {
                          if (_signUpFormKey.currentState!.validate()) {
                            _signUpFormKey.currentState!.save();
                            data = await LoginPostMethod(
                                    email: email, password: password)
                                .createLogin();
                            if (data["message"] == "Success") {
                              String token = data["token"];
                              String firstName = data["user"]["firstName"];
                              String lastName = data["user"]["lastName"];
                              String email = data["user"]["email"];
                              debugPrint('$email');
                              user = data["user"];
                              String tokenData = data["token"];
                              debugPrint(
                                  'This is the token from the login: ${token}');

                              TokenSharedPrefernces.instance
                                  .setTokenValue("token", tokenData);
                              TokenSharedPrefernces.instance
                                  .setNameValue("firstName", firstName);
                              TokenSharedPrefernces.instance
                                  .setNameValue("lastName", lastName);
                              TokenSharedPrefernces.instance
                                  .setEmailValue("email", email);

                              debugPrint(user["firstName"].toString());
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomePage(
                                            userData: user,
                                            dataList: getterData,
                                          )));
                            } else {
                              AlertDialog alert = AlertDialog(
                                title: const Text('Invalid Credentials'),
                                content: const Text('User not found'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            }
                          }
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 70),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(120, 121, 241, 1)),
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                          child: Text('Dont Have an Account Yet?',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ))),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RegisterPage()));
                        },
                        child: Text('Register Now!',
                            style: TextStyle(
                              color: Color.fromRGBO(131, 123, 255, 1),
                              fontSize: 16,
                            )),
                      )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
