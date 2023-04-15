import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mb_control/models/model.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/operation/provider_in_dropdown.dart';
import 'package:mb_control/views/operation/provider_out_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';

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
      future: userHndl.getModels(),
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
                Container(
                  width: 80,
                  padding: const EdgeInsets.all(8.0),
                  child: StepperSwipe(
                    initialValue: 0,
                    speedTransitionLimitCount: 3,
                    onChanged: (int value) =>
                        userHndl.models[e.key]['value'] = value,
                    firstIncrementDuration: const Duration(
                        milliseconds: 250), //Unit time before fast counting
                    secondIncrementDuration: const Duration(
                        milliseconds: 100), //Unit time during fast counting
                    direction: Axis.horizontal,
                    dragButtonColor: Colors.blueAccent,
                    maxValue: 50,
                    minValue: 0,
                    stepperValue: 1,
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
                        userHndl.models[e.key]['hasIva'] = val;
                        setState(() {
                          status[e.key] = val;
                        });
                      },
                    ),
                  ),
                ),
              if (widget.showProviders)
                const DataCell(
                  SizedBox(width: 256, child: ProviderInDropDown()),
                ),
              if (widget.showProviders)
                const DataCell(
                  SizedBox(width: 256, child: ProviderOutDropDown()),
                ),
            ]),
          )
          .toList(),
    );
  }
}
