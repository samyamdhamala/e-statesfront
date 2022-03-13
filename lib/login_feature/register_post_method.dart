import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:login/api/endpoint.dart';

class RegisterPostMethod {
  final String firstName;
  final String lastName;
  final String state;
  final String dob;
  final String occupation;
  final String email;
  final String phonenumber;
  final String password;

  RegisterPostMethod({
    required this.dob,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.occupation,
    required this.password,
    required this.phonenumber,
    required this.state,
  });

  Future<String> createRegister() async {
    final Uri url = Uri.parse(registerUserEndPoint);
    final header = {"content-type": "application/json"};
    final response = await http.post(
      url,
      headers: header,
      body: json.encode(
        {
          'firstname': firstName,
          'lastname': lastName,
          'dob': dob,
          'state': state,
          'occupation': occupation,
          'email': email,
          'phonenumber': phonenumber,
          'password': password,
        },
      ),
    );
    debugPrint('${response.statusCode}');

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      return map["message"].toString();
    }
    return "Invalid Credentials";
  }
}
