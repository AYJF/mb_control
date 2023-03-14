List<Users> usersFromJson(List list) {
  return list.map((e) => Users.fromJson(e)).toList();
}

class Users {
  final String? email;
  final String? userName;
  final String? requestedAt;
  final String? confirmedAt;
  final List<dynamic>? roles;
  final bool? isConfirmed;
  final bool? isLocked;

  const Users({
    required this.email,
    required this.userName,
    required this.requestedAt,
    required this.roles,
    required this.confirmedAt,
    this.isConfirmed,
    this.isLocked,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        email: json['email'],
        userName: json['userName'],
        requestedAt: json['requestedAt'],
        roles: json['roles'],
        confirmedAt: json['confirmedAt'],
        isConfirmed: json['isConfirmed'],
        isLocked: json['isLocked'],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "token": userName,
        "requestedAt": requestedAt,
        "roles": roles,
        "confirmedAt": confirmedAt,
        "isConfirmed": isConfirmed,
        "isLocked": isLocked,
      };
}
