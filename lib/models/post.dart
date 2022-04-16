import 'package:flutter/material.dart';
import 'package:login/models/property_model.dart';
import 'dart:convert';

class Post {
  String message;
  dynamic data;

  Post({
    required this.message,
    required this.data,
  });

  factory Post.fromJson(Map<String, dynamic> data) {
    debugPrint('This is the returned data: ${data.toString()}');
    return Post(
      message: data['message'],
      data: PropertyModel.fromJson(json.decode(data['data'])),
    );
  }
}
