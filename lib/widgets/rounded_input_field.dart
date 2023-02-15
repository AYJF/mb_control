import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mb_control/tools/color_hex.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final String? Function(String? value)? validator;

  const RoundedInputField(
      {Key? key, this.hintText, this.icon, this.onChanged, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w300,
        fontSize: 12,
      ),
      onChanged: onChanged,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(width: 1, color: HexColor('#C2CFF0')),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(width: 1, color: HexColor('#C2CFF0')),
        ),
        filled: true,
        hintStyle: TextStyle(
          color: HexColor('#CFCCCC'),
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        hintText: hintText,
        fillColor: HexColor('#FFFFFF'),
        prefixIcon: Icon(
          icon ?? MaterialIcons.email,
          color: HexColor('#C2CFF0'),
        ),
      ),
    );
  }
}
