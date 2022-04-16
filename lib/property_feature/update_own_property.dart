import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:login/api/endpoint.dart';
import 'package:login/token_shared_preferences.dart';
import 'package:http/http.dart ' as http;

class UpdateOwnProperty {
  final String id;
  final String streetaddress;
  final String city;
  final String name;
  final String province;
  final String area;
  final String longitude;
  final String latitude;
  final String description;
  final String type;
  final String status;
  final int price;

  UpdateOwnProperty({
    required this.id,
    required this.name,
    required this.streetaddress,
    required this.description,
    required this.city,
    required this.area,
    required this.province,
    required this.longitude,
    required this.latitude,
    required this.type,
    required this.status,
    required this.price,
  });

  Future<dynamic> updateProperty() async {
    String tokenValue =
        await TokenSharedPrefernces.instance.getTokenValue("token");
    final Uri url = Uri.parse(editOwnPropertyEndpoint + id);
    debugPrint(url.toString());
    final header = {
      "content-type": "application/json",
      "Authorization": tokenValue,
    };
    final response = await http.patch(url,
        headers: header,
        body: json.encode(<String, String>{
          'name': name,
          'streetaddress': streetaddress,
          'city': city,
          'province': province,
          'area': area,
          'longitude': longitude,
          'latitude': latitude,
          'description': description,
          'type': type,
          'status': status,
          'price': price.toString(),
        }));
    debugPrint('This is the response of update property: ${response.body}');
    Map<String, dynamic> map = json.decode(response.body);
    String message = map["message"];
    if (response.statusCode == 200) {
      return 'success';
    } else {
      return message;
    }
  }
}
