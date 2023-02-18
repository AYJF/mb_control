import 'package:flutter/material.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:mb_control/views/client/models_table.dart';
import 'package:provider/provider.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';
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
              ToggleSwitch(
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
              ),
              const SizedBox(height: 15),
              const _Clientes(),
              const SizedBox(height: 15),
              const _Empresas(),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (userHndl.wInvoice == 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Factura"),
                        Container(
                          width: 80,
                          padding: const EdgeInsets.all(8.0),
                          child: StepperSwipe(
                            initialValue: 0,
                            speedTransitionLimitCount: 3,
                            onChanged: (int value) {},

                            firstIncrementDuration: const Duration(
                                milliseconds:
                                    250), //Unit time before fast counting
                            secondIncrementDuration: const Duration(
                                milliseconds:
                                    100), //Unit time during fast counting
                            direction: Axis.horizontal,
                            dragButtonColor: Colors.blueAccent,
                            maxValue: 50,
                            minValue: 0,
                            stepperValue: 1,
                          ),
                        ),
                      ],
                    ),
                  if (userHndl.total == 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Total"),
                        Container(
                          width: 80,
                          padding: const EdgeInsets.all(8.0),
                          child: StepperSwipe(
                            initialValue: 0,
                            speedTransitionLimitCount: 3,
                            onChanged: (int value) {},

                            firstIncrementDuration: const Duration(
                                milliseconds:
                                    250), //Unit time before fast counting
                            secondIncrementDuration: const Duration(
                                milliseconds:
                                    100), //Unit time during fast counting
                            direction: Axis.horizontal,
                            dragButtonColor: Colors.blueAccent,
                            maxValue: 50,
                            minValue: 0,
                            stepperValue: 1,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              ToggleSwitch(
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
              ),
              const ModelsTable(
                showLastColumn: false,
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
            ],
          ),
        ),
      ),
    );
  }
}

class _Clientes extends StatelessWidget {
  const _Clientes({super.key});

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return FutureBuilder(
      future: userHndl.getClients(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: SizedBox(
            width: 250,
            child: DropdownButtonFormField<String>(
              value: snapshot.data![0].id,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
              onChanged: (String? value) {
                userHndl.promoterID = value;
              },
              items: snapshot.data!.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value.id,
                  child: Text(value.name ?? ""),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class _Empresas extends StatelessWidget {
  const _Empresas({super.key});

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return FutureBuilder(
      future: userHndl.getCompanies(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: SizedBox(
            width: 250,
            child: DropdownButtonFormField<String>(
              value: snapshot.data![0].id,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
              onChanged: (String? value) {
                userHndl.promoterID = value;
              },
              items: snapshot.data!.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value.id,
                  child: Text(value.name ?? ""),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
