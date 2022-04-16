import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/api/endpoint.dart';
import '../models/property_model.dart';
import '../token_shared_preferences.dart';

class GetOwnerContact {
  static Future<dynamic> getOwnerContact(String property) async {
    String tokenValue =
        await TokenSharedPrefernces.instance.getTokenValue("token");
    final Uri url = Uri.parse(getOwnerContactEndpoint + property);
    debugPrint(url.toString());
    final header = {
      "content-type": "application/json",
      "Authorization": tokenValue,
    };
    final response = await http.get(url, headers: header);
    debugPrint('This is the response of get owner contact: ${response.body}');
    Map<String, dynamic> map = json.decode(response.body);
    dynamic user = map["user"];
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      return user;
    } else {
      return user;
    }
  }
}
