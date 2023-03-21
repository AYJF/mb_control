import 'package:flutter/material.dart';
import 'package:mb_control/models/provider_income.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:mb_control/views/promoters/promoter_table_handler.dart';
import 'package:mb_control/views/provider_income/provider_income_data_source.dart';
import 'package:provider/provider.dart';

class ProviderIcomeTable extends StatefulWidget {
  const ProviderIcomeTable({Key? key}) : super(key: key);

  @override
  State<ProviderIcomeTable> createState() => _ProviderIcomeTableState();
}

class _ProviderIcomeTableState extends State<ProviderIcomeTable> {
  List<bool> selected = List<bool>.generate(100, (index) => false);

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    final _provider = context.watch<PromoterDataNotifier>();
    return Base(
        title: "Listado de Proveedores",
        showBackBtn: true,
        body: FutureBuilder<List<ProviderIcome>>(
            future: userHndl.getProviderIncome(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: 600.0,
                  child: SingleChildScrollView(
                    child: PaginatedDataTable(
                      header: const Text('Proveedores'),
                      showCheckboxColumn: true,
                      onRowsPerPageChanged: (index) =>
                          _provider.rowsPerPage = index!,
                      rowsPerPage: _provider.rowsPerPage,
                      sortColumnIndex: _provider.sortColumnIndex,
                      sortAscending: _provider.sortAscending,
                      columns: const [
                        DataColumn(label: Text('Nombre')),
                        DataColumn(label: Text('Factura')),
                        DataColumn(label: Text('Numero de Factura')),
                        DataColumn(label: Text('Fact. Total')),
                        DataColumn(label: Text('No. Fact. Total')),
                      ],
                      source: ProviderIcomeDTS(snapshot.data!),
                    ),
                  ),
                ),
              );
            }));
  }
}
