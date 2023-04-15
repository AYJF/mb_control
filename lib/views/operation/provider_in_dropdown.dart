import 'package:flutter/material.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:provider/provider.dart';

class ProviderInDropDown extends StatelessWidget {
  const ProviderInDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return FutureBuilder(
      future: userHndl.getProviderIncome(),
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
              onChanged: (String? value) {},
              items: snapshot.data!.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value.id,
                  child: Text(value.name?.toString() ?? ""),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
