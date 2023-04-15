import 'package:flutter/material.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:mb_control/views/client/models_table.dart';
import 'package:mb_control/views/operation/invoice_drop_down.dart';
import 'package:mb_control/views/operation/operation_next_folio.dart';
import 'package:mb_control/widgets/clients_dropdown.dart';
import 'package:mb_control/widgets/comany_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Retorno extends StatefulWidget {
  const Retorno({Key? key}) : super(key: key);

  @override
  State<Retorno> createState() => _RetornoState();
}

class _RetornoState extends State<Retorno> {
  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return Base(
      title: "Retorno",
      showBackBtn: true,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const _InvoiceSwitch(),
              const SizedBox(height: 15),
              const ClientesDropdown(),
              const SizedBox(height: 15),
              const EmpresasDropDown(),
              const SizedBox(height: 15),
              const InvoiceDropDown(),
              const SizedBox(height: 15),
              const OperationNextFolio(),
              const SizedBox(height: 15),
              const _TotalSwitch(),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ModelsTable(
                  showLastColumn: false,
                  showProviders: true,
                ),
              ),
              const SizedBox(height: 25),
              userHndl.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36)),
                        minimumSize: const Size(200, 50),
                      ),
                      child: const Text(
                        'Guardar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class _InvoiceSwitch extends StatelessWidget {
  const _InvoiceSwitch();

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return ToggleSwitch(
      minWidth: 110.0,
      minHeight: 35.0,
      fontSize: 12.0,
      initialLabelIndex: userHndl.wInvoice,
      activeBgColor: const [Colors.green],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.grey[900],
      totalSwitches: 2,
      labels: const ['CON FACTURA', 'SIN FACTURA'],
      onToggle: (index) {
        userHndl.wInvoice = index!;
      },
    );
  }
}

class _TotalSwitch extends StatelessWidget {
  const _TotalSwitch();

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return ToggleSwitch(
      minWidth: 110.0,
      minHeight: 35.0,
      fontSize: 12.0,
      initialLabelIndex: userHndl.total,
      activeBgColor: const [Colors.green],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.grey[900],
      totalSwitches: 2,
      labels: const ['TOTAL', 'PARCIAL'],
      onToggle: (index) {
        userHndl.total = index!;
      },
    );
  }
}
