List<ProviderIcome> providerIncomeFromJson(List list) {
  return list.map((e) => ProviderIcome.fromJson(e)).toList();
}

class ProviderIcome {
  final String? id;
  final String? name;
  final double? invoiceAmount;
  final double? noInvoiceAmount;
  final bool? invoiceTotal;
  final bool? noInvoiceTotal;

  const ProviderIcome(
      {required this.id,
      required this.name,
      required this.invoiceAmount,
      required this.noInvoiceAmount,
      required this.invoiceTotal,
      required this.noInvoiceTotal});

  factory ProviderIcome.fromJson(Map<String, dynamic> json) => ProviderIcome(
        id: json['id'],
        name: json['name'],
        invoiceAmount: json['invoiceAmount'].toDouble(),
        noInvoiceAmount: json['noInvoiceAmount'].toDouble(),
        invoiceTotal: json['invoiceTotal'],
        noInvoiceTotal: json['noInvoiceTotal'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "noInvoiceAmount": noInvoiceAmount,
        "invoiceTotal": invoiceTotal,
        "noInvoiceTotal": noInvoiceTotal,
      };
}
