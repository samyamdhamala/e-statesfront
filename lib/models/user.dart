class User {
  int id;
  String firstName;
  String lastname;
  String phoneNumber;
  String email;
  String password;

  User(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastname,
      required this.password,
      required this.phoneNumber});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firstName: json['firstName'],
        lastname: json['lastname'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
        password: json['password']);
  }
}
