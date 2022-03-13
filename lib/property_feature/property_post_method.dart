import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/api/endpoint.dart';
import 'package:login/token_shared_preferences.dart';

class PropertyPostMethod {
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
  File? image;

  PropertyPostMethod({
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
    required this.image,
  });

  Future<String> createProperty() async {
    final Uri url = Uri.parse(postNewPropertyEndPoint);
    String tokenValue =
        await TokenSharedPrefernces.instance.getTokenValue("token");
    final header = {
      "content-type": "application/json",
      "Authorization": tokenValue
    };

    debugPrint('This is the token value ${tokenValue}');
    debugPrint(image!.path);

    var request = http.MultipartRequest("POST", url);
    request.headers.addAll(header);
    request.fields['name'] = name;
    request.fields['streetaddress'] = streetaddress;
    request.fields['city'] = city;
    request.fields['province'] = province;
    request.fields['area'] = area;
    request.fields['longitude'] = longitude;
    request.fields['latitude'] = latitude;
    request.fields['description'] = description;
    request.fields['type'] = type;
    request.fields['status'] = status;
    request.fields['price'] = price.toString();
    var pic = await http.MultipartFile.fromPath('propertyImage', image!.path);
    request.files.add(pic);

    debugPrint('This is the sent name: ${request.fields['name']}');

    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print('This is the response ${responseString}');

    debugPrint('This is the status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      return "Post Created Successfully";
    } else {
      throw "Invalid Credentials";
    }
  }
}


