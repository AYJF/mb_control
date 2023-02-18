import 'package:flutter/material.dart';
import 'package:mb_control/models/operation.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:mb_control/views/operation/link_operation_chart.dart';

import 'package:mb_control/views/operation/operation_data_source.dart';
import 'package:mb_control/views/promoters/promoter_table_handler.dart';
import 'package:provider/provider.dart';

class OperationTable extends StatefulWidget {
  const OperationTable({Key? key}) : super(key: key);

  @override
  State<OperationTable> createState() => _OperationTableState();
}

class _OperationTableState extends State<OperationTable> {
  List<bool> selected = List<bool>.generate(100, (index) => false);

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    final _provider = context.watch<PromoterDataNotifier>();
    return Base(
        title: "Listado de Operaciones",
        showBackBtn: true,
        body: FutureBuilder<List<Operation>>(
            future: userHndl.getOperations(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              Map<String, dynamic> _listTem = {};
              for (var e in snapshot.data!) {
                if (e.userName == 'Totales') continue;
                _listTem.containsKey(e.userName!)
                    ? _listTem[e.userName!] += e.totalOperacion
                    : _listTem.putIfAbsent(e.userName!, () => e.totalOperacion);
              }

              print(_listTem);

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 600.0,
                        child: SingleChildScrollView(
                          child: PaginatedDataTable(
                            header: const Text('Operaciones'),
                            showCheckboxColumn: true,
                            onRowsPerPageChanged: (index) =>
                                _provider.rowsPerPage = index ?? 0,
                            rowsPerPage: 5,
                            availableRowsPerPage: const [5, 10, 20],
                            sortColumnIndex: _provider.sortColumnIndex,
                            sortAscending: _provider.sortAscending,
                            columns: const [
                              DataColumn(label: Text('Admin/Enlace')),
                              DataColumn(label: Text('Promotor')),
                              DataColumn(label: Text('Cliente')),
                              DataColumn(label: Text('Empresa')),
                              DataColumn(label: Text('Factura')),
                              DataColumn(label: Text('Total Operaciones')),
                              DataColumn(label: Text('SubTotal Operaciones')),
                            ],
                            source: OperationDTS(snapshot.data!),
                          ),
                        ),
                      ),
                      PieChartSample2(
                        data: _listTem,
                        total: snapshot.data!.last.totalOperacion!,
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
