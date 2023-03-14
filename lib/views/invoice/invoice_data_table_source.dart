import 'package:flutter/material.dart';
import 'package:mb_control/models/invoice.dart';

class InvoiceDTS extends DataTableSource {
  InvoiceDTS(this.userData);
  final List<Invoice> userData;
  @override
  DataRow getRow(int index) {
    final user = userData[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(user.number.toString())),
        DataCell(Text(user.totalAmount.toString())),
        DataCell(Text(user.remainingAmount.toString())),
        DataCell(Text(user.userEmail ?? "")),
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
