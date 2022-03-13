import 'package:login/models/user.dart';

class Login {
  String message;
  User user;
  String token;

  Login({
    required this.message,
    required this.user,
    required this.token,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      message: json['message'],
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }

  static Map<String, dynamic> toJson() {
    String? message;
    List<User>? user;
    String? token;

    Map<String, dynamic> jsonData = {};

    jsonData['message'] = message;
    jsonData['user'] = user;
    jsonData['token'] = token;

    return jsonData;
  }
}
