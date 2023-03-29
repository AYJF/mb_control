import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:mb_control/widgets/rounded_input_field.dart';
import 'package:provider/provider.dart';

class CreateProviderIn extends StatefulWidget {
  const CreateProviderIn({Key? key}) : super(key: key);

  @override
  State<CreateProviderIn> createState() => _CreateProviderInState();
}

class _CreateProviderInState extends State<CreateProviderIn> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return Base(
        title: "Crear Proveedor de ingreso",
        showBackBtn: true,
        body: Center(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      child: RoundedInputField(
                        hintText: "Nombre",
                        icon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nombre no puede ser vacio';
                          }
                          return null;
                        },
                        onChanged: (value) => userHndl.providerName = value,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Facturacion"),
                        SizedBox(
                          width: 150,
                          child: RoundedInputField(
                            hintText: "Costo",
                            icon: Icons.money_off,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Costo no puede ser vacio';
                              }
                              return null;
                            },
                            onChanged: (value) => userHndl.costoFactura = value,
                          ),
                        ),
                        Column(
                          children: [
                            const Text("Total/Subtotal"),
                            SizedBox(
                              width: 56,
                              child: FlutterSwitch(
                                width: 50.0,
                                height: 25.0,
                                valueFontSize: 25.0,
                                toggleSize: 24.0,
                                value: userHndl.providerFactura,
                                borderRadius: 30.0,
                                padding: 2.0,
                                showOnOff: false,
                                onToggle: (val) =>
                                    userHndl.providerFactura = val,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Sin factura"),
                        SizedBox(
                          width: 150,
                          child: RoundedInputField(
                            hintText: "Costo",
                            icon: Icons.money_off,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nombre no puede ser vacio';
                              }
                              return null;
                            },
                            onChanged: (value) =>
                                userHndl.costoWithoutFactura = value,
                          ),
                        ),
                        Column(
                          children: [
                            const Text("Total/Subtotal"),
                            SizedBox(
                              width: 56,
                              child: FlutterSwitch(
                                width: 50.0,
                                height: 25.0,
                                valueFontSize: 25.0,
                                toggleSize: 24.0,
                                value: userHndl.providerWithOutFactura,
                                borderRadius: 30.0,
                                padding: 2.0,
                                showOnOff: false,
                                onToggle: (val) =>
                                    userHndl.providerWithOutFactura = val,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 45),
                    userHndl.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                userHndl.isLoading = true;

                                print(await userHndl.createProviderInCome());

                                userHndl.isLoading = false;
                              }
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
                  ],
                ),
              )),
        ));
  }
}
