import 'package:flutter/material.dart';
import 'package:mb_control/models/company.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:mb_control/views/company/company_data_source.dart';
import 'package:mb_control/views/promoters/promoter_table_handler.dart';
import 'package:provider/provider.dart';

class CompaniesTable extends StatefulWidget {
  const CompaniesTable({Key? key}) : super(key: key);

  @override
  State<CompaniesTable> createState() => _CompaniesTableState();
}

class _CompaniesTableState extends State<CompaniesTable> {
  List<bool> selected = List<bool>.generate(100, (index) => false);

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    final provider = context.watch<PromoterDataNotifier>();
    return Base(
        title: "Listado de Empresas",
        showBackBtn: true,
        body: FutureBuilder<List<Company>>(
            future: userHndl.getCompanies(),
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
                          provider.rowsPerPage = index!,
                      rowsPerPage: provider.rowsPerPage,
                      sortColumnIndex: provider.sortColumnIndex,
                      sortAscending: provider.sortAscending,
                      columns: const [
                        DataColumn(label: Text('Empresa')),
                      ],
                      source: CompanyDTS(snapshot.data!),
                    ),
                  ),
                ),
              );
            }));
  }
}
