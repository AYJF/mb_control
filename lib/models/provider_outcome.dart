import 'package:mb_control/models/model.dart';

List<ProviderOutcome> providerOutcomeFromJson(List list) {
  return list.map((e) => ProviderOutcome.fromJson(e)).toList();
}

class ProviderOutcome {
  final String? id;
  final String? name;
  final List<ProviderOutComeModel>? models;

  const ProviderOutcome(
      {required this.id, required this.name, required this.models});

  factory ProviderOutcome.fromJson(Map<String, dynamic> json) =>
      ProviderOutcome(
        id: json['id'],
        name: json['name'],
        models: providerOutComeModelFromJson(json['providerOutComeModels']),
      );
}
