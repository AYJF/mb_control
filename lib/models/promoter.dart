List<Promoter> promoterModelFromJson(List list) {
  return list.map((e) => Promoter.fromJson(e)).toList();
}

class Promoter {
  final String? email;
  final String? id;
  final String? name;
  final String? userName;
  final String? phone;
  final bool? contactByEmail;
  final bool? contactByPhone;

  const Promoter({
    required this.email,
    required this.id,
    required this.name,
    required this.userName,
    this.phone,
    this.contactByEmail,
    this.contactByPhone,
  });
  static const empty =
      Promoter(email: null, id: null, name: null, userName: null);

  factory Promoter.fromJson(Map<String, dynamic> json) => Promoter(
        email: json['email'],
        id: json['id'],
        name: json['name'],
        userName: json['userName'],
        phone: json['phone'],
        contactByEmail: json['contactByEmail'],
        contactByPhone: json['contactByPhone'],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
        "name": name,
        "userName": userName,
        "phone": phone,
        "contactByEmail": contactByEmail,
        "contactByPhone": contactByPhone
      };
}
