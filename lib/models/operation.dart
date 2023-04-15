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
  final double? comisionTotal;
  final double? comisionPromoter;
  final double? comisionUtilidadMB;
  final double? excedente;
  final double? costoProviderOutcome;
  final double? costoProviderIncome;

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
    this.comisionTotal,
    this.comisionPromoter,
    this.comisionUtilidadMB,
    this.excedente,
    this.costoProviderIncome,
    this.costoProviderOutcome,
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
        comisionTotal: json['comisionTotal'].toDouble(),
        comisionPromoter: json['comisionPromoter'].toDouble(),
        comisionUtilidadMB: json['comisionUtilidadMB'].toDouble(),
        excedente: json['excedente'].toDouble(),
        costoProviderIncome: json['costoProviderIncome'].toDouble(),
        costoProviderOutcome: json['costoProviderOutcome'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
