import 'package:flutter/material.dart';
import 'package:login/api/endpoint.dart';
import 'package:http/http.dart' as http;

import '../token_shared_preferences.dart';

class AllPropertyGetMethod {
  final String message;
  final String data;

  AllPropertyGetMethod({
    required this.message,
    required this.data,
  });

  static Future<Map<String, dynamic>> getAllProperty() async {
    String tokenValue =
        await TokenSharedPrefernces.instance.getTokenValue("token");
    final Uri url = Uri.parse(fetchAllPropertyEndpoint);
    final header = {
      "content-type": "application/json",
      "Authorization": tokenValue,
    };

    final response = await http.get(url, headers: header);
    debugPrint(response.body);

    if (response.statusCode == 200) {
      return {
        'message': 'Success',
        'data': response.body,
      };
    } else {
      return {
        'message': 'Failed',
        'data': response.body,
      };
    }
  }
}
