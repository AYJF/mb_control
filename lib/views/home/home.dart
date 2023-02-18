import 'package:flutter/material.dart';
import 'package:mb_control/views/base/base.dart';
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
            const Operaciones(),
            const SizedBox(height: 45),
            FloatingActionButton(
                heroTag: "uno",
                onPressed: () {
                  Navigator.of(context).pushNamed('/operations');
                }),
            FloatingActionButton(
                heroTag: "dos",
                onPressed: () {
                  Navigator.of(context).pushNamed('/promoters');
                }),
            FloatingActionButton(
                heroTag: "ttes",
                onPressed: () {
                  Navigator.of(context).pushNamed('/company');
                }),
            TextButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Seleccione la Operacion'),
                  insetPadding: const EdgeInsets.symmetric(horizontal: 1),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            Navigator.of(context).pushNamed('/retorno'),
                        child: SizedBox(
                          height: 120,
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                    color: Colors.grey, shape: BoxShape.circle),
                                child: Image.asset(
                                  'assets/images/shapes/calculadora.png',
                                  width: 25,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text("Retorno")
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          height: 120,
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                    color: Colors.grey, shape: BoxShape.circle),
                                child: Image.asset(
                                  'assets/images/shapes/cross.png',
                                  width: 25,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text("Asignar Factura")
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              child: const Text('Show Dialog'),
            ),
          ],
        ));
  }
}
