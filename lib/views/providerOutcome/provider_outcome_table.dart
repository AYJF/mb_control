import 'package:flutter/material.dart';
import 'package:mb_control/models/provider_outcome.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:mb_control/views/promoters/promoter_table_handler.dart';
import 'package:mb_control/views/providerOutcome/provider_outcome_data_source.dart';
import 'package:provider/provider.dart';

class ProviderOutcomeTable extends StatefulWidget {
  const ProviderOutcomeTable({Key? key}) : super(key: key);

  @override
  State<ProviderOutcomeTable> createState() => _ProviderOutcomeTableState();
}

class _ProviderOutcomeTableState extends State<ProviderOutcomeTable> {
  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    final _provider = context.watch<PromoterDataNotifier>();
    return Base(
        title: "Listado de Proveedores",
        showBackBtn: true,
        body: FutureBuilder<List<ProviderOutcome>>(
            future: userHndl.getProviderOutcome(),
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
                        DataColumn(label: Text('Cargo')),
                        DataColumn(label: Text('Cargo total')),
                        DataColumn(label: Text('Modelos')),
                      ],
                      source: ProviderOutcomeDTS(snapshot.data!),
                    ),
                  ),
                ),
              );
            }));
  }
}
