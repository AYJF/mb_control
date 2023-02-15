import 'package:flutter/material.dart';
import 'package:mb_control/models/promoter.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:mb_control/views/client/models_table.dart';
import 'package:mb_control/widgets/rounded_input_field.dart';
import 'package:provider/provider.dart';

class CreateClient extends StatefulWidget {
  const CreateClient({Key? key}) : super(key: key);

  @override
  State<CreateClient> createState() => _CreateClientState();
}

class _CreateClientState extends State<CreateClient> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return Base(
      title: "Crear Cliente",
      showBackBtn: true,
      body: FutureBuilder(
        future: userHndl.getPromoters(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: RoundedInputField(
                    hintText: "Nombrte del Cliente ",
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
                    hintText: "RFC",
                    icon: Icons.person,
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
                const ModelsTable(),
                const SizedBox(height: 25),
                const Text("Promotores"),
                Center(
                  child: SizedBox(
                    width: 250,
                    child: DropdownButtonFormField<String>(
                      value: snapshot.data![0].id,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                      onChanged: (String? value) {
                        userHndl.promoterID = value;
                      },
                      items: snapshot.data!
                          .map<DropdownMenuItem<String>>((Promoter value) {
                        return DropdownMenuItem<String>(
                          value: value.id,
                          child: Text(value.name ?? ""),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                userHndl.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            userHndl.isLoading = true;

                            // final bool isValid = await userHndl.login();
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
          );
        },
      ),
    );
  }
}
