import 'package:flutter/material.dart';
import 'package:mb_control/models/client_model.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:mb_control/views/client/cliente_data_source.dart';
import 'package:mb_control/views/promoters/promoter_table_handler.dart';
import 'package:provider/provider.dart';

class ClientTable extends StatefulWidget {
  const ClientTable({Key? key}) : super(key: key);

  @override
  State<ClientTable> createState() => _ClientTableState();
}

class _ClientTableState extends State<ClientTable> {
  List<bool> selected = List<bool>.generate(100, (index) => false);

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    final _provider = context.watch<PromoterDataNotifier>();
    return Base(
        title: "Listado de Promotores",
        showBackBtn: true,
        body: FutureBuilder<List<UserClient>>(
            future: userHndl.getClients(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: 400.0,
                  child: SingleChildScrollView(
                    child: PaginatedDataTable(
                      header: const Text('Clientes'),
                      showCheckboxColumn: true,
                      onRowsPerPageChanged: (index) =>
                          _provider.rowsPerPage = index!,
                      rowsPerPage: _provider.rowsPerPage,
                      sortColumnIndex: _provider.sortColumnIndex,
                      sortAscending: _provider.sortAscending,
                      columns: const [
                        DataColumn(label: Text('Cliente')),
                        DataColumn(label: Text('Admin/Enlace')),
                        DataColumn(label: Text('Promotor')),
                        DataColumn(label: Text('RFC')),
                      ],
                      source: ClientDTS(snapshot.data!),
                    ),
                  ),
                ),
              );
            }));
  }
}
