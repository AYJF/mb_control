import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';

import 'package:mb_control/models/model.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:mb_control/views/client/models_table.dart';
import 'package:mb_control/views/operation/provider_in_dropdown.dart';
import 'package:mb_control/views/operation/provider_out_dropdown.dart';

import 'package:mb_control/widgets/models_dropdown.dart';
import 'package:mb_control/widgets/rounded_input_field.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ComisionCalculator extends StatelessWidget {
  const ComisionCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return Base(
        title: 'Calculadora de comisiones',
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // const _InvoiceSwitch(),
                // const SizedBox(height: 10),
                // userHndl.realVirtual == 1
                //     ? Container()
                //     : const ClientesDropdown(),
                const SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  child: RoundedInputField(
                      hintText: "Total",
                      icon: Icons.calculate,
                      validator: (value) {
                        return null;
                      },
                      onChanged: (value) {
                        userHndl.totalOperation = double.tryParse(value) ?? 0.0;
                      }),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Promotor',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                const ModelsTable(
                  lastColumnName: 'PISO/%',
                ),
                const SizedBox(height: 10),
                const Text(
                  'Cliente',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                const ModelsTable(),
                const ModelsDropDown(),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _ModelsTable(
                    showLastColumn: false,
                    showProviders: true,
                  ),
                ),
                const SizedBox(height: 25),
                userHndl.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          await userHndl.createOperationCalculator();
                        },
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
                const SizedBox(height: 25),
              ],
            ),
          ),
        ));
  }
}

class _ModelsTable extends StatelessWidget {
  const _ModelsTable({
    Key? key,
    this.lastColumnName = 'CONIVA/IVA',
    this.showLastColumn = true,
    this.showProviders = false,
  }) : super(key: key);

  final String lastColumnName;
  final bool showLastColumn;

  final bool showProviders;
  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return FutureBuilder(
      future: userHndl.getModel(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _TableWidget(
            models: snapshot.data,
            lastColumnName: lastColumnName,
            showLastColumn: showLastColumn,
            showProviders: showProviders,
          ),
        );
      },
    );
  }
}

class _TableWidget extends StatefulWidget {
  const _TableWidget({
    required this.models,
    required this.lastColumnName,
    required this.showLastColumn,
    required this.showProviders,
  });

  final List<Model>? models;
  final String lastColumnName;
  final bool showLastColumn;
  final bool showProviders;

  @override
  State<_TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<_TableWidget> {
  List<bool> status = [];

  @override
  void initState() {
    status = List.generate(widget.models!.length, (index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);

    return DataTable(
      columnSpacing: 15.0,
      dataRowHeight: widget.showProviders ? 75 : null,
      columns: [
        const DataColumn(label: Text('Modelos')),
        const DataColumn(label: Text('Comision')),
        if (widget.showLastColumn)
          DataColumn(label: Text(widget.lastColumnName)),
        if (widget.showProviders)
          const DataColumn(
            label: Text("Proveedor Ingreso"),
          ),
        if (widget.showProviders)
          const DataColumn(
            label: Text("Proveedor Egreso"),
          ),
      ],
      rows: widget.models!
          .asMap()
          .entries
          .map(
            (e) => DataRow(cells: [
              DataCell(Text(e.value.name ?? "")),
              DataCell(
                SizedBox(
                  width: 130,
                  height: 35,
                  child: SpinBox(
                    min: 1,
                    max: 10000,
                    value: 1,
                    decimals: 0,
                    textAlign: TextAlign.center,
                    textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    incrementIcon: const Icon(Icons.keyboard_arrow_up,
                        size: 20, color: Colors.black),
                    decrementIcon: const Icon(Icons.keyboard_arrow_down,
                        size: 20, color: Colors.black),
                    iconColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.grey;
                      }
                      if (states.contains(MaterialState.error)) {
                        return Colors.red;
                      }
                      if (states.contains(MaterialState.focused)) {
                        return Colors.blue;
                      }
                      return Colors.black;
                    }),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ),
              if (widget.showProviders)
                DataCell(
                  SizedBox(
                      width: 256,
                      child: ProviderInDropDown(
                        onChanged: (value) {
                          userHndl.operationsModels[e.key]['providerIncomeId'] =
                              value;
                        },
                      )),
                ),
              if (widget.showProviders)
                DataCell(
                  SizedBox(
                      width: 256,
                      child: ProviderOutDropDown(
                        onChanged: (value) {
                          userHndl.operationsModels[e.key]
                              ['providerOutcomeId'] = value;
                        },
                      )),
                ),
            ]),
          )
          .toList(),
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
      initialLabelIndex: userHndl.realVirtual,
      activeBgColor: const [Colors.green],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.grey[900],
      totalSwitches: 2,
      labels: const ['REAL', 'VIRTUAL'],
      onToggle: (index) {
        userHndl.realVirtual = index!;
      },
    );
  }
}
