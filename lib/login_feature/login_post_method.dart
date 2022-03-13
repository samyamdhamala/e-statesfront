import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:login/api/endpoint.dart';

class LoginPostMethod {
  final String email;
  final String password;

  LoginPostMethod({required this.email, required this.password});

  Future<Map<String, dynamic>> createLogin() async {
    final Uri url = Uri.parse(loginUserEndPoint);
    final header = {"content-type": "application/json"};
    final response = await http.post(
      url,
      headers: header,
      body: json.encode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
    debugPrint('${response.statusCode}');

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      debugPrint(map.toString());
      return map;
    } else if (response.statusCode == 404) {
      Map<String, dynamic> map = json.decode(response.body);
      debugPrint(map.toString());
      return map;
    }
    throw UnimplementedError();
  }
}
