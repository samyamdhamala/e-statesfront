import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
class PageBuilder extends StatefulWidget {
  PageBuilder({Key? key}) : super(key: key);

  @override
  State<PageBuilder> createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  bool _obscureText = true;
  DateTime date = DateTime(2022, 4, 13);

  TextEditingController _date = new TextEditingController();

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
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Image.asset('assets/images/register.png'),
          ),
          Container(
            child: Text(
              'Create an Account',
              style: GoogleFonts.lato(
                  color: Color.fromRGBO(120, 121, 241, 1),
                  fontSize: 28,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Form(
            key: _registerKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                          validator:
                              RequiredValidator(errorText: "Cannot be Empty"),
                          onSaved: (value) {
                            firstName = value.toString();
                          },
                          decoration: InputDecoration(
                              labelText: 'First Name',
                              labelStyle:
                                  Theme.of(context).textTheme.labelMedium)),
                    ),
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                          validator:
                              RequiredValidator(errorText: "Cannot be Empty"),
                          onSaved: (value) {
                            lastName = value.toString();
                          },
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.person),
                              labelText: 'Last Name',
                              labelStyle:
                                  Theme.of(context).textTheme.labelMedium)),
                    ),
                  ],
                ),
                TextFormField(
                    readOnly: true,
                    controller: _date,
                    autocorrect: false,
                    validator: RequiredValidator(
                        errorText: "Please enter a valid dob."),
                    onTap: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2023),
                      );
                      //if cancel null is returned
                      if (newDate == null) return;

                      //if newDate is not null then set the date
                      setState(() {
                        date = newDate;
                        print(date.toString());
                        // _date.value = TextEditingValue(text: date.toString());
                        _date.text = DateFormat.yMd().format(date);
                      });
                    },
                    onSaved: (value) {
                      dob = value.toString();
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.calendar_month_sharp),
                        labelText: 'Date Of Birth',
                        labelStyle: Theme.of(context).textTheme.labelMedium)),
                TextFormField(
                    validator: RequiredValidator(
                        errorText: "Please enter a valid State."),
                    onSaved: (value) {
                      state = value.toString();
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.location_city),
                        labelText: 'State',
                        labelStyle: Theme.of(context).textTheme.labelMedium)),
                TextFormField(
                    validator: RequiredValidator(
                        errorText: "Please enter a valid Occupation."),
                    onSaved: (value) {
                      occupation = value.toString();
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.work),
                        labelText: 'Occupation',
                        labelStyle: Theme.of(context).textTheme.labelMedium)),
                TextFormField(
                    onSaved: (value) {
                      email = value.toString();
                    },
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Pleaser enter your email"),
                      EmailValidator(errorText: "Please enter a valid email"),
                    ]),
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.mail),
                        labelText: 'Email Address',
                        labelStyle: Theme.of(context).textTheme.labelMedium)),
                TextFormField(
                    onSaved: (value) {
                      phoneno = value.toString();
                    },
                    validator: RequiredValidator(
                        errorText: "Please enter a valid Phone Number."),
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.phone),
                        labelText: 'Phone Number',
                        labelStyle: Theme.of(context).textTheme.labelMedium)),
                TextFormField(
                    onSaved: (value) {
                      password = value.toString();
                    },
                    validator: RequiredValidator(
                        errorText: "Please enter your password!"),
                    obscureText: _obscureText,
                    decoration: InputDecoration(
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
                        labelText: 'Password',
                        labelStyle: Theme.of(context).textTheme.labelMedium)),
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
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
