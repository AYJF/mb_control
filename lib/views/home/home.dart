import 'package:flutter/material.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:mb_control/views/home/components/courusel_linker.dart';
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
          children: [
            const SizedBox(height: 25),
            const Operaciones(),
            const SizedBox(height: 55),
            const CouruselLinker(),
            const SizedBox(height: 65),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/report-date'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36)),
                minimumSize: const Size(200, 50),
              ),
              child: const Text(
                'Reporte',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            // SizedBox(height: 45),
            // ListComonents(),
          ],
        ));
  }
}
