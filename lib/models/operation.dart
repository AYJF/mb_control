List<Operation> operationFromJson(List list) {
  return list.map((e) => Operation.fromJson(e)).toList();
}

class Operation {
  final String? id;
  final String? clientId;
  final String? clientName;
  final String? userName;
  final String? promoterId;
  final String? promoterName;
  final String? companyId;
  final String? companyName;
  final String? factura;
  final double? totalOperacion;
  final double? subTotalOperacion;

  const Operation({
    required this.id,
    this.clientId,
    this.clientName,
    this.userName,
    this.promoterId,
    this.promoterName,
    this.companyId,
    this.companyName,
    this.factura,
    this.totalOperacion,
    this.subTotalOperacion,
  });
  static const empty = Operation(id: null);

  factory Operation.fromJson(Map<String, dynamic> json) => Operation(
        id: json['id'],
        clientId: json['clientId'],
        clientName: json['clientName'],
        userName: json['userName'],
        promoterId: json['promoterId'],
        promoterName: json['promoterName'],
        companyId: json['companyId'],
        companyName: json['companyName'],
        factura: json['factura'],
        totalOperacion: json['totalOperacion'].toDouble(),
        subTotalOperacion: json['subTotalOperacion'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
