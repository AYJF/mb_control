import 'package:flutter/material.dart';
import 'package:mb_control/models/promoter.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:mb_control/views/promoters/data_source.dart';
import 'package:mb_control/views/promoters/promoter_table_handler.dart';
import 'package:provider/provider.dart';

class PromoterTable extends StatefulWidget {
  const PromoterTable({Key? key}) : super(key: key);

  @override
  State<PromoterTable> createState() => _PromoterTableState();
}

class _PromoterTableState extends State<PromoterTable> {
  List<bool> selected = List<bool>.generate(100, (index) => false);

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    final _provider = context.watch<PromoterDataNotifier>();
    return Base(
        title: "Listado de Promotores",
        showBackBtn: true,
        body: FutureBuilder<List<Promoter>>(
            future: userHndl.getPromoters(),
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
                      header: const Text('Promoters'),
                      showCheckboxColumn: true,
                      onRowsPerPageChanged: (index) =>
                          _provider.rowsPerPage = index!,
                      rowsPerPage: _provider.rowsPerPage,
                      sortColumnIndex: _provider.sortColumnIndex,
                      sortAscending: _provider.sortAscending,
                      columns: const [
                        DataColumn(label: Text('Promotor')),
                        DataColumn(label: Text('Admin/Enlace')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('WhatsApp')),
                        DataColumn(label: Text('Cell')),
                      ],
                      source: PromoterDTS(snapshot.data!),
                    ),
                  ),
                ),
              );
            }));
  }
}
