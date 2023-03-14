import 'package:flutter/material.dart';
import 'package:mb_control/models/invoice.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:mb_control/views/invoice/invoice_data_table_source.dart';
import 'package:mb_control/views/promoters/promoter_table_handler.dart';
import 'package:provider/provider.dart';

class InvoiceTable extends StatefulWidget {
  const InvoiceTable({Key? key}) : super(key: key);

  @override
  State<InvoiceTable> createState() => _InvoiceTableState();
}

class _InvoiceTableState extends State<InvoiceTable> {
  List<bool> selected = List<bool>.generate(100, (index) => false);

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    final _provider = context.watch<PromoterDataNotifier>();
    return Base(
        title: "Listado de Facturas",
        showBackBtn: true,
        body: FutureBuilder<List<Invoice>>(
            future: userHndl.getInvoices(),
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
                      header: const Text('Facturas'),
                      showCheckboxColumn: true,
                      onRowsPerPageChanged: (index) =>
                          _provider.rowsPerPage = index!,
                      rowsPerPage: _provider.rowsPerPage,
                      sortColumnIndex: _provider.sortColumnIndex,
                      sortAscending: _provider.sortAscending,
                      columns: const [
                        DataColumn(label: Text('Numero')),
                        DataColumn(label: Text('Total')),
                        DataColumn(label: Text('Remanente')),
                        DataColumn(label: Text('Usuario')),
                      ],
                      source: InvoiceDTS(snapshot.data!),
                    ),
                  ),
                ),
              );
            }));
  }
}
