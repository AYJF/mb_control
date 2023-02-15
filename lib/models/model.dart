List<Model> modelFromJson(List list) {
  return list.map((e) => Model.fromJson(e)).toList();
}

class Model {
  final String? name;
  final String? id;

  const Model({
    required this.name,
    required this.id,
  });
  static const empty = Model(name: null, id: null);

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        name: json['name'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
