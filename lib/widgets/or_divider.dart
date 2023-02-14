import 'package:flutter/material.dart';
import 'package:mb_control/tools/color_hex.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 1.5,
          width: 100,
          decoration: BoxDecoration(color: HexColor("#EEF2F6")),
        ),
        const SizedBox(width: 16),
        const Text("Or"),
        const SizedBox(width: 16),
        Container(
          height: 1.5,
          width: 100,
          decoration: BoxDecoration(color: HexColor("#EEF2F6")),
        ),
      ],
    );
  }
}
