List<Promoter> promoterModelFromJson(List list) {
  return list.map((e) => Promoter.fromJson(e)).toList();
}

class Promoter {
  final String? email;
  final String? id;
  final String? name;
  final String? userName;

  const Promoter(
      {required this.email,
      required this.id,
      required this.name,
      required this.userName});
  static const empty =
      Promoter(email: null, id: null, name: null, userName: null);

  factory Promoter.fromJson(Map<String, dynamic> json) => Promoter(
        email: json['email'],
        id: json['id'],
        name: json['name'],
        userName: json['userName'],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
        "name": name,
        "userName": userName,
      };
}
