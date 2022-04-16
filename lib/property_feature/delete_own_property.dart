import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/api/endpoint.dart';
import '../models/property_model.dart';
import '../token_shared_preferences.dart';

class DeleteOwnProperty {
  // final String message;
  final String property;

  DeleteOwnProperty({
    // required this.message,
    required this.property,
  });

  Future<dynamic> deleteOwnProperty() async {
    String tokenValue =
        await TokenSharedPrefernces.instance.getTokenValue("token");
    final Uri url = Uri.parse(deleteOwnPropertyEndpoint + property);
    debugPrint(url.toString());
    final header = {
      "content-type": "application/json",
      "Authorization": tokenValue,
    };
    final response = await http.delete(url, headers: header);
    debugPrint('This is the response of delete own property: ${response.body}');
    Map<String, dynamic> map = json.decode(response.body);
    String message = map["message"];
    if (response.statusCode == 200) {
      return 'success';
    } else {
      return message;
    }
  }
}
