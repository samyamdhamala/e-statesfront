import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login/api/endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:login/models/property_model.dart';
import '../token_shared_preferences.dart';

class GetAllProperty {
  final String message;
  final String data;

  GetAllProperty({
    required this.message,
    required this.data,
  });

  static Future<Map<String, dynamic>> getAllPropertyInit() async {
    String tokenValue =
        await TokenSharedPrefernces.instance.getTokenValue("token");
    final Uri url = Uri.parse(getAllPropertyEndpoint);
    final header = {
      "content-type": "application/json",
      "Authorization": tokenValue,
    };

    final response = await http.get(url, headers: header);

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

  static Future<List<PropertyModel>> getAllProperty() async {
    String tokenValue =
        await TokenSharedPrefernces.instance.getTokenValue("token");
    final Uri url = Uri.parse(getAllPropertyEndpoint);
    final header = {
      "content-type": "application/json",
      "Authorization": tokenValue,
    };

    final response = await http.get(url, headers: header);
    debugPrint('This is the response of all property: ${response.body}');

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

  static Future<List<PropertyModel>> getAllHouses() async {
    String tokenValue =
        await TokenSharedPrefernces.instance.getTokenValue("token");
    final Uri url = Uri.parse(getPropertyByTypeEndpoint + 'house');
    final header = {
      "content-type": "application/json",
      "Authorization": tokenValue,
    };

    final response = await http.get(url, headers: header);
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

  static Future<List<PropertyModel>> getAllLands() async {
    String tokenValue =
        await TokenSharedPrefernces.instance.getTokenValue("token");
    final Uri url = Uri.parse(getPropertyByTypeEndpoint + 'land');
    final header = {
      "content-type": "application/json",
      "Authorization": tokenValue,
    };

    final response = await http.get(url, headers: header);
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
