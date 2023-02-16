import 'package:mb_control/models/model.dart';

List<UserClient> clientModelFromJson(List list) {
  return list.map((e) => UserClient.fromJson(e)).toList();
}

class UserClient {
  final String? id;
  final String? name;
  final String? userName;
  final String? promoterId;
  final String? promoterName;
  final String? rfc;
  final List<Model>? models;

  const UserClient({
    required this.id,
    required this.name,
    required this.userName,
    this.models,
    this.promoterId,
    this.promoterName,
    this.rfc,
  });

  static const empty =
      UserClient(id: null, name: null, userName: null, models: []);

  factory UserClient.fromJson(Map<String, dynamic> json) => UserClient(
        id: json['id'],
        name: json['name'],
        userName: json['userName'],
        models: modelFromJson(json['models']),
        promoterId: json['promoterId'],
        promoterName: json['promoterName'],
        rfc: json['rfc'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "userName": userName,
      };
}
