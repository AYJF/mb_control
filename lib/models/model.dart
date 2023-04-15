List<Model> modelFromJson(List list) {
  return list.map((e) => Model.fromJson(e)).toList();
}

List<ProviderOutComeModel> providerOutComeModelFromJson(List list) {
  return list.map((e) => ProviderOutComeModel.fromJson(e)).toList();
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

class ProviderOutComeModel {
  final String? modelName;
  final String? modelId;
  final double? charge;
  final bool? isTotal;

  const ProviderOutComeModel({
    required this.modelName,
    required this.modelId,
    required this.charge,
    required this.isTotal,
  });
  static const empty = Model(name: null, id: null);

  factory ProviderOutComeModel.fromJson(Map<String, dynamic> json) =>
      ProviderOutComeModel(
        modelName: json['modelName'],
        modelId: json['modelId'],
        charge: json['charge'].toDouble(),
        isTotal: json['isTotal'],
      );
}
