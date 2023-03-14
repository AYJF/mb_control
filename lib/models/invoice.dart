List<Invoice> invoiceFromJson(List list) {
  return list.map((e) => Invoice.fromJson(e)).toList();
}

class Invoice {
  final String? id;
  final String? userEmail;
  final int? number;
  final int? totalAmount;
  final int? remainingAmount;

  const Invoice({
    required this.id,
    required this.userEmail,
    required this.number,
    required this.totalAmount,
    required this.remainingAmount,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json['id'],
        userEmail: json['userEmail'],
        number: json['number'],
        totalAmount: json['totalAmount'],
        remainingAmount: json['remainingAmount'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userEmail": userEmail,
        "number": number,
        "totalAmount": totalAmount,
        "remainingAmount": remainingAmount,
      };
}
