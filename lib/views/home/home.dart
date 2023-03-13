import 'package:flutter/material.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:mb_control/views/home/components/list_comonents.dart';
import 'package:mb_control/views/home/components/operaciones.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Base(
        title: "Catálogo",
        body: Column(
          children: const [
            Operaciones(),
            // SizedBox(height: 45),
            // ListComonents(),
          ],
        ));
  }
}
