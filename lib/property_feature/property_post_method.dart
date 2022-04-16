import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/api/endpoint.dart';
import 'package:login/token_shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

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
  final List<File>? image;

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

    Map<String, String> headers = {
      "content-Type": "application/json",
      "Authorization": tokenValue,
    };

    var request = http.MultipartRequest("POST", url);
    request.headers.addAll(headers);
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

    debugPrint('This is the image path: ${image![0].path}');



    for (var images in image!) {
      var pic = await http.MultipartFile.fromPath(
        "propertyImage",
        images.path,
        filename: 'image.jpg',
        contentType: MediaType('image', 'jpg'),
      );
      print(pic);
      request.files.add(pic);
    }

    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    debugPrint(request.toString());
    print('This is the response ${responseString}');

    debugPrint('This is the status code: ${(response.statusCode).toString()}');

    if (response.statusCode == 200) {
      return "Sucess";
    } else {
      return "response code: ${response.statusCode}";
    }
  }
}
