import 'package:flutter/material.dart';
import 'package:mb_control/models/operation.dart';

class OperationDTS extends DataTableSource {
  OperationDTS(
    this.userData, {
    required this.onRowSelected,
  });
  final List<Operation> userData;
  final Function(Operation operation) onRowSelected;

  @override
  DataRow getRow(int index) {
    final user = userData[index];

    return DataRow.byIndex(
      index: index,
      onSelectChanged: (value) {
        print(value);
        print(index);

        onRowSelected(userData[index]);
      },
      cells: [
        DataCell(Text(user.userName ?? "")),
        DataCell(Text(user.promoterName ?? "")),
        DataCell(Text(user.clientName ?? "")),
        DataCell(Text(user.companyName ?? "")),
        DataCell(Text(user.factura ?? "")),
        DataCell(Text(user.totalOperacion.toString())),
        DataCell(Text(user.subTotalOperacion.toString())),
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
