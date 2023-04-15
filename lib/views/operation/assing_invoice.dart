import 'package:flutter/material.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:mb_control/widgets/clients_dropdown.dart';
import 'package:mb_control/widgets/comany_dropdown.dart';
import 'package:mb_control/widgets/models_dropdown.dart';
import 'package:mb_control/widgets/rounded_input_field.dart';
import 'package:provider/provider.dart';

class AssingInvoice extends StatefulWidget {
  const AssingInvoice({Key? key}) : super(key: key);

  @override
  State<AssingInvoice> createState() => _AssingInvoiceState();
}

class _AssingInvoiceState extends State<AssingInvoice> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return Base(
        title: "Assignar factura",
        showBackBtn: true,
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                const ClientesDropdown(),
                const SizedBox(height: 15),
                const EmpresasDropDown(),
                const SizedBox(height: 15),
                const ModelsDropDown(),
                const SizedBox(height: 15),
                SizedBox(
                  width: 250,
                  child: RoundedInputField(
                    hintText: "Numero de Factura",
                    icon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Factura no valida';
                      }
                      return null;
                    },
                    onChanged: (value) => userHndl.invoiceNumber = value,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 250,
                  child: RoundedInputField(
                    hintText: "Monto",
                    icon: Icons.money_rounded,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Monto no valido';
                      }
                      return null;
                    },
                    onChanged: (value) => userHndl.invoiceAmount = value,
                  ),
                ),
                const SizedBox(height: 15),
                userHndl.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            userHndl.isLoading = true;

                            print(userHndl.invoiceAmount);
                            print(userHndl.invoiceNumber);
                            print(userHndl.clientID);
                            print(userHndl.companyId);
                            print(userHndl.modelID);
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
          ),
        ));
  }
}
