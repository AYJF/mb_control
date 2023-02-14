List<User> movieModelFromJson(List list) {
  return list.map((e) => User.fromJson(e)).toList();
}

class User {
  final String? email;
  final String? token;
  final String? errorMessage;
  final List<String>? roles;

  const User({
    required this.email,
    required this.token,
    required this.errorMessage,
    required this.roles,
  });
  static const empty =
      User(email: null, token: null, errorMessage: null, roles: []);

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        token: json['token'],
        errorMessage: json['errorMessage'],
        roles: json['imdbID'],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "token": token,
        "errorMessage": errorMessage,
        "roles": roles,
      };
}
