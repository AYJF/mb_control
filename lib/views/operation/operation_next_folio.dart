import 'package:flutter/material.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:provider/provider.dart';

class OperationNextFolio extends StatelessWidget {
  const OperationNextFolio({super.key});

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return FutureBuilder(
      future: userHndl.getOperationNextFolio(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: SizedBox(
            width: 250,
            child: Center(child: Text(snapshot.data ?? "")),
          ),
        );
      },
    );
  }
}
