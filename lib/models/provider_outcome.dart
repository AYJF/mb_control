import 'package:mb_control/models/model.dart';

List<ProviderOutcome> providerOutcomeFromJson(List list) {
  return list.map((e) => ProviderOutcome.fromJson(e)).toList();
}

class ProviderOutcome {
  final String? id;
  final String? name;
  final double? charge;
  final bool? totalCharge;
  final List<Model>? models;

  const ProviderOutcome(
      {required this.id,
      required this.name,
      required this.charge,
      required this.totalCharge,
      required this.models});

  factory ProviderOutcome.fromJson(Map<String, dynamic> json) =>
      ProviderOutcome(
        id: json['id'],
        name: json['name'],
        charge: json['charge'].toDouble(),
        totalCharge: json['totalCharge'],
        models: modelFromJson(json['models']),
      );
}
