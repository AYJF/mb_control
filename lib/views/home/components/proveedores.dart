import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:mb_control/views/providers/create_provider_in.dart';

class Proveedores extends StatefulWidget {
  const Proveedores({Key? key}) : super(key: key);

  @override
  State<Proveedores> createState() => _ProveedoresState();
}

class _ProveedoresState extends State<Proveedores> {
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  final double _fabDimension = 50.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                        return const CreateProviderIn();
                      }),
                  const SizedBox(height: 8),
                  const Text(
                    "Proveedor Ingreso",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              // Column(
              //   children: [
              //     OpenContainer(
              //         closedElevation: 0.0,
              //         closedShape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.all(
              //             Radius.circular(_fabDimension / 2),
              //           ),
              //         ),
              //         transitionType: _transitionType,
              //         closedColor: Colors.white,
              //         closedBuilder: (context, action) {
              //           return SizedBox(
              //             height: _fabDimension,
              //             width: _fabDimension,
              //             child: Center(
              //               child: Image.asset(
              //                 'assets/images/shapes/user.png',
              //                 width: 50,
              //                 height: 50,
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           );
              //         },
              //         openBuilder: (context, action) {
              //           return const CreateProviderIn();
              //         }),
              //     const SizedBox(height: 8),
              //     const Text(
              //       "Proveedor Egreso",
              //       style: TextStyle(color: Colors.black),
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
