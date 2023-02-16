import 'package:flutter/material.dart';
import 'package:mb_control/models/client_model.dart';

class ClientDTS extends DataTableSource {
  ClientDTS(this.userData);
  final List<UserClient> userData;
  @override
  DataRow getRow(int index) {
    final user = userData[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(user.name ?? "")),
        DataCell(Text(user.userName ?? "")),
        DataCell(Text(user.promoterName ?? "")),
        DataCell(Text(user.rfc ?? "")),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
