import 'package:flutter/material.dart';
import 'package:mb_control/models/company.dart';

class CompanyDTS extends DataTableSource {
  CompanyDTS(this.userData);
  final List<Company> userData;
  @override
  DataRow getRow(int index) {
    final user = userData[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(user.name ?? "")),
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
