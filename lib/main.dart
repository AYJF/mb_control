import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/client/clients_table.dart';
import 'package:mb_control/views/company/companies_table.dart';
import 'package:mb_control/views/company/create_company.dart';
import 'package:mb_control/views/home/home.dart';
import 'package:mb_control/views/invoice/invoice_table.dart';
import 'package:mb_control/views/operation/assing_invoice.dart';
import 'package:mb_control/views/operation/comision_calculator.dart';
import 'package:mb_control/views/operation/operantion_table.dart';
import 'package:mb_control/views/operation/retorno.dart';
import 'package:mb_control/views/promoters/promoter_table_handler.dart';
import 'package:mb_control/views/promoters/promoters_table.dart';
import 'package:mb_control/views/providerOutcome/provider_outcome_table.dart';
import 'package:mb_control/views/provider_income/provider_income_table.dart';
import 'package:mb_control/views/providers/create_provider_in.dart';
import 'package:mb_control/views/report/report_select_date.dart';
import 'package:mb_control/views/users/users_table.dart';
import 'package:mb_control/views/welcome/intro.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserHndl()),
        ChangeNotifierProvider(create: (_) => PromoterDataNotifier()),
      ],
      child: MaterialApp(
        title: 'MB-Control',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (_) => const Intro(),
          '/home': (_) => const Home(),
          '/clients': (_) => const ClientTable(),
          '/operations': (_) => const OperationTable(),
          '/promoters': (_) => const PromoterTable(),
          '/company': (_) => const CreateCompany(),
          '/companies': (_) => const CompaniesTable(),
          '/users': (_) => const UserTable(),
          '/invoices': (_) => const InvoiceTable(),
          '/report-date': (_) => const ReportSelectDate(),
          '/retorno': (_) => const Retorno(),
          '/assing-invoice': (_) => const AssingInvoice(),
          '/proveedores-in': (_) => const ProviderIcomeTable(),
          '/proveedores-out': (_) => const ProviderOutcomeTable(),
          'create-provider-in': (_) => const CreateProviderIn(),
          '/comision-calculator': (_) => const ComisionCalculator(),
        },
      ),
    );
  }
}
