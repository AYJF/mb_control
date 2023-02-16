import 'package:flutter/material.dart';
import 'package:mb_control/models/promoter.dart';

class PromoterDTS extends DataTableSource {
  PromoterDTS(this.userData);
  final List<Promoter> userData;
  @override
  DataRow getRow(int index) {
    final user = userData[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(user.name ?? "")),
        DataCell(Text(user.userName ?? "")),
        DataCell(Text(user.email ?? "")),
        DataCell(user.contactByEmail!
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : const Icon(
                Icons.error,
                color: Colors.red,
              )),
        DataCell(user.contactByPhone!
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : const Icon(
                Icons.error,
                color: Colors.red,
              )),
        DataCell(Text(user.phone ?? "")),
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
