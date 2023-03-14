import 'package:flutter/material.dart';
import 'package:mb_control/models/users.dart';

class UserDTS extends DataTableSource {
  UserDTS(this.userData);
  final List<Users> userData;
  @override
  DataRow getRow(int index) {
    final user = userData[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(user.userName ?? "")),
        DataCell(Text(user.email ?? "")),
        DataCell(Text(user.roles
                ?.fold<String>(
                    "", (previousValue, element) => "$element,$previousValue")
                .toString() ??
            "")),
        DataCell(user.isConfirmed!
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : const Icon(
                Icons.error,
                color: Colors.red,
              )),
        DataCell(Text(user.requestedAt ?? "")),
        DataCell(Text(user.confirmedAt ?? "")),
        DataCell(!(user.isLocked ?? false)
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
