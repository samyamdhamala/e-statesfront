import 'dart:convert';
import 'package:login/api/endpoint.dart';
import 'package:http/http.dart' as http;
import '../token_shared_preferences.dart';

class LikeUnlikeProperty{
  final String message;
  final String data;

  LikeUnlikeProperty({
    required this.message,
    required this.data,
  });

  static Future<Map<String, dynamic>> likeUnlikePropertyInit(String propertyId, bool action) async {
    String tokenValue =
        await TokenSharedPrefernces.instance.getTokenValue("token");
    final Uri url = Uri.parse(likeOrUnlikePropertyEndpoint + propertyId);
    final header = {
      "content-type": "application/json",
      "Authorization": tokenValue,
    };

    final response = await http.post(url, headers: header, body: json.encode({
      "property_id": propertyId,
      "action": action,
    }));

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