import 'package:flutter/material.dart';
import 'package:mb_control/models/provider_outcome.dart';

class ProviderOutcomeDTS extends DataTableSource {
  ProviderOutcomeDTS(this.userData);
  final List<ProviderOutcome> userData;
  @override
  DataRow getRow(int index) {
    final user = userData[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(user.name ?? "")),
        DataCell(Text(user.charge.toString())),
        DataCell(user.totalCharge!
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : const Icon(
                Icons.error,
                color: Colors.red,
              )),
        DataCell(Text(user.models
                ?.fold<String>(
                    "",
                    (previousValue, element) =>
                        "${element.name},$previousValue")
                .toString() ??
            "")),
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
