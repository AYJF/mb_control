import 'package:flutter/material.dart';
import 'package:mb_control/models/provider_income.dart';

class ProviderIcomeDTS extends DataTableSource {
  ProviderIcomeDTS(this.userData);
  final List<ProviderIcome> userData;
  @override
  DataRow getRow(int index) {
    final user = userData[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(user.name ?? "")),
        DataCell(Text(user.invoiceAmount.toString())),
        DataCell(Text(user.noInvoiceAmount.toString())),
        DataCell(user.invoiceTotal!
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : const Icon(
                Icons.error,
                color: Colors.red,
              )),
        DataCell(user.noInvoiceTotal!
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : const Icon(
                Icons.error,
                color: Colors.red,
              )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => userData.length;

  @override
  int get selectedRowCount => 0;
}
