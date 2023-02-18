List<Company> companyFromJson(List list) {
  return list.map((e) => Company.fromJson(e)).toList();
}

class Company {
  final String? name;
  final String? id;

  const Company({
    required this.name,
    required this.id,
  });
  static const empty = Company(name: null, id: null);

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json['name'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
