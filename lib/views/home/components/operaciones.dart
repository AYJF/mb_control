import 'package:flutter/material.dart';
import 'package:mb_control/tools/color_hex.dart';
import 'package:animations/animations.dart';
import 'package:mb_control/views/client/clients_table.dart';
import 'package:mb_control/views/client/create_client.dart';
import 'package:mb_control/views/promoters/create_promoters.dart';

class Operaciones extends StatefulWidget {
  const Operaciones({Key? key}) : super(key: key);

  @override
  State<Operaciones> createState() => _OperacionesState();
}

class _OperacionesState extends State<Operaciones> {
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  final double _fabDimension = 50.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            'Operaciones',
            style: TextStyle(
              color: HexColor('#111827'),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 45),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  OpenContainer(
                      closedElevation: 0.0,
                      closedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(_fabDimension / 2),
                        ),
                      ),
                      transitionType: _transitionType,
                      closedColor: Colors.white,
                      closedBuilder: (context, action) {
                        return SizedBox(
                          height: _fabDimension,
                          width: _fabDimension,
                          child: Center(
                            child: Image.asset(
                              'assets/images/shapes/user.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      openBuilder: (context, action) {
                        return const CreateClient();
                      }),
                  const SizedBox(height: 8),
                  const Text(
                    "Nuevo Cliente",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Column(
                children: [
                  OpenContainer(
                      closedElevation: 0.0,
                      closedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(_fabDimension / 2),
                        ),
                      ),
                      transitionType: _transitionType,
                      closedColor: Colors.grey,
                      closedBuilder: (context, action) {
                        return SizedBox(
                          height: _fabDimension,
                          width: _fabDimension,
                          child: Center(
                            child: Image.asset(
                              'assets/images/shapes/cross.png',
                              width: 35,
                              height: 35,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      openBuilder: (context, action) {
                        return const CreatePromoters();
                      }),
                  const SizedBox(height: 8),
                  const Text(
                    "Crear Promotor",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Column(
                children: [
                  OpenContainer(
                      closedElevation: 0.0,
                      closedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(_fabDimension / 2),
                        ),
                      ),
                      transitionType: _transitionType,
                      closedColor: Colors.grey,
                      closedBuilder: (context, action) {
                        return SizedBox(
                          height: _fabDimension,
                          width: _fabDimension,
                          child: Center(
                            child: Image.asset(
                              'assets/images/shapes/astronaut.png',
                              width: 35,
                              height: 35,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      openBuilder: (context, action) {
                        return const ClientTable();
                      }),
                  const SizedBox(height: 8),
                  const Text(
                    "Nuevo Empresa",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
