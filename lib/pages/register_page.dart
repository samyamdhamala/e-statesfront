import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login/login_feature/register_post_method.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageBuilder(),
      ),
    );
  }
}

@immutable
class PageBuilder extends StatelessWidget {
  PageBuilder({Key? key}) : super(key: key);

  final _registerKey = GlobalKey<FormState>();
  late String firstName = '';
  late String lastName = '';
  late String state = '';
  late String dob = '';
  late String occupation = '';
  late String email = '';
  late String phoneno = '';
  late String password = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset('assets/images/register.png'),
          Container(
            child: const Text(
              'Create an Account',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Form(
            key: _registerKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(children: [
                TextFormField(
                    validator: RequiredValidator(
                        errorText: "Please enter a valid first name."),
                    onSaved: (value) {
                      firstName = value.toString();
                    },
                    decoration: InputDecoration(
                        labelText: 'First Name',
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(40, 32, 175, 1)))),
                TextFormField(
                    validator: RequiredValidator(
                        errorText: "Please enter a valid Last Name."),
                    onSaved: (value) {
                      lastName = value.toString();
                    },
                    decoration: InputDecoration(
                        labelText: 'Last Name',
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(40, 32, 175, 1)))),
                TextFormField(
                    validator: RequiredValidator(
                        errorText: "Please enter a valid dob."),
                    onSaved: (value) {
                      dob = value.toString();
                    },
                    decoration: InputDecoration(
                        labelText: 'DOB',
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(40, 32, 175, 1)))),
                TextFormField(
                    validator: RequiredValidator(
                        errorText: "Please enter a valid State."),
                    onSaved: (value) {
                      state = value.toString();
                    },
                    decoration: InputDecoration(
                        labelText: 'State',
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(40, 32, 175, 1)))),
                TextFormField(
                    validator: RequiredValidator(
                        errorText: "Please enter a valid Occupation."),
                    onSaved: (value) {
                      occupation = value.toString();
                    },
                    decoration: InputDecoration(
                        labelText: 'Occupation',
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(40, 32, 175, 1)))),
                TextFormField(
                    onSaved: (value) {
                      email = value.toString();
                    },
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Pleaser enter your email"),
                      EmailValidator(errorText: "Please enter a valid email"),
                    ]),
                    decoration: InputDecoration(
                        labelText: 'Email Name',
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(40, 32, 175, 1)))),
                TextFormField(
                    onSaved: (value) {
                      phoneno = value.toString();
                    },
                    validator: RequiredValidator(
                        errorText: "Please enter a valid Phone Number."),
                    decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(40, 32, 175, 1)))),
                TextFormField(
                    onSaved: (value) {
                      password = value.toString();
                    },
                    validator: RequiredValidator(
                        errorText: "Please enter your password!"),
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(40, 32, 175, 1)))),
              ]),
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () async {
              if (_registerKey.currentState!.validate()) {
                _registerKey.currentState!.save();
                String data = await RegisterPostMethod(
                        dob: dob,
                        firstName: firstName,
                        lastName: lastName,
                        state: state,
                        occupation: occupation,
                        email: email,
                        phonenumber: phoneno,
                        password: password)
                    .createRegister();
                debugPrint(
                    '$firstName $lastName $state $occupation $email $phoneno $password');
                if (data == "Success") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User Registered'),
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  AlertDialog alert = AlertDialog(
                    title: const Text('Invalid User Details'),
                    content: const Text('User could not be created'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
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
              child: const Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              'By signing up, you agree with the Terms of Service and Privacy Policy.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final String labelText;

  const TextFieldWidget({
    Key? key,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      margin: const EdgeInsets.only(bottom: 5.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: labelText,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
