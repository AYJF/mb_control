import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:mb_control/views/client/models_table.dart';
import 'package:mb_control/widgets/rounded_input_field.dart';
import 'package:provider/provider.dart';

class CreatePromoters extends StatefulWidget {
  const CreatePromoters({Key? key}) : super(key: key);

  @override
  State<CreatePromoters> createState() => _CreatePromotersState();
}

class _CreatePromotersState extends State<CreatePromoters> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return Base(
      title: "Crear promotor",
      showBackBtn: true,
      body: FutureBuilder(
        future: userHndl.getPromoters(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: RoundedInputField(
                      hintText: "Nombrte",
                      icon: Icons.person,
                      validator: (value) {
                        return null;
                      },
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 250,
                    child: RoundedInputField(
                      hintText: "Email",
                      icon: Icons.email,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !EmailValidator.validate(value)) {
                          return 'Email is not valid';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        userHndl.email = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 250,
                    child: RoundedInputField(
                      hintText: "Telefono",
                      icon: Icons.phone,
                      validator: (value) {
                        // if (value == null ||
                        //     value.isEmpty ||
                        //     !EmailValidator.validate(value)) {
                        //   return 'Email is not valid';
                        // }
                        return null;
                      },
                      onChanged: (value) {
                        userHndl.email = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  const ModelsTable(
                    lastColumnName: 'PISO/%',
                  ),
                  const SizedBox(height: 25),
                  const Text("Método de contacto"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Email"),
                        SizedBox(
                          width: 56,
                          child: FlutterSwitch(
                            width: 50.0,
                            height: 25.0,
                            valueFontSize: 25.0,
                            toggleSize: 24.0,
                            value: userHndl.contactByEmail,
                            borderRadius: 30.0,
                            padding: 2.0,
                            showOnOff: false,
                            onToggle: (val) => userHndl.contactByEmail = val,
                          ),
                        ),
                        Text("WhatsApp"),
                        SizedBox(
                          width: 56,
                          child: FlutterSwitch(
                            width: 50.0,
                            height: 25.0,
                            valueFontSize: 25.0,
                            toggleSize: 24.0,
                            value: userHndl.contactByPhone,
                            borderRadius: 30.0,
                            padding: 2.0,
                            showOnOff: false,
                            onToggle: (val) => userHndl.contactByPhone = val,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  userHndl.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              userHndl.isLoading = true;

                              userHndl.models.forEach((element) {
                                print(element);
                              });
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
          );
        },
      ),
    );
  }
}
