import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login/api/endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:login/models/property_model.dart';

import '../token_shared_preferences.dart';

class GetOwnProperty {
  final String message;
  final String data;

  GetOwnProperty({
    required this.message,
    required this.data,
  });

  static Future<List<PropertyModel>> getOwnProperty() async {
    String tokenValue =
        await TokenSharedPrefernces.instance.getTokenValue("token");
    final Uri url = Uri.parse(getOwnPropertyEndpoint);
    final header = {
      "content-type": "application/json",
      "Authorization": tokenValue,
    };

    final response = await http.get(url, headers: header);
    debugPrint('This is the response of own property: ${response.body}');

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["data"];
    if (response.statusCode == 200) {
      return data
          .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw UnimplementedError();
    }
  }

  static Future<List<PropertyModel>> getBookmarkedProperty() async {
    String tokenValue =
        await TokenSharedPrefernces.instance.getTokenValue("token");
    final Uri url = Uri.parse(getBookmarkedPropertyEndpoint);
    final header = {
      "content-type": "application/json",
      "Authorization": tokenValue,
    };

    final response = await http.get(url, headers: header);
    debugPrint('This is the response of bookmarked property: ${response.body}');

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["data"];
    if (response.statusCode == 200) {
      return data
          .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw UnimplementedError();
    }
  }
}
