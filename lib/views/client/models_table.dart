import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mb_control/models/model.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/operation/provider_in_dropdown.dart';
import 'package:mb_control/views/operation/provider_out_dropdown.dart';
import 'package:provider/provider.dart';
// import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';

class ModelsTable extends StatelessWidget {
  const ModelsTable({
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
      future: lastColumnName == 'CONIVA/IVA'
          ? userHndl.getClientsModels()
          : userHndl.getPromoterModels(),
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
              if (widget.showLastColumn)
                DataCell(
                  SizedBox(
                    width: 56,
                    child: FlutterSwitch(
                      width: 50.0,
                      height: 25.0,
                      valueFontSize: 25.0,
                      toggleSize: 24.0,
                      value: status[e.key],
                      borderRadius: 30.0,
                      padding: 2.0,
                      showOnOff: false,
                      onToggle: (val) {
                        widget.lastColumnName == 'CONIVA/IVA'
                            ? userHndl.models[e.key]['hasIva'] = val
                            : userHndl.modelsPromoters[e.key]['isPercent'] =
                                val;
                        setState(() {
                          status[e.key] = val;
                        });
                      },
                    ),
                  ),
                ),
              if (widget.showProviders)
                DataCell(
                  SizedBox(
                      width: 256,
                      child: ProviderInDropDown(
                        onChanged: (value) {},
                      )),
                ),
              if (widget.showProviders)
                DataCell(
                  SizedBox(
                      width: 256,
                      child: ProviderOutDropDown(
                        onChanged: (value) {},
                      )),
                ),
            ]),
          )
          .toList(),
    );
  }
}
