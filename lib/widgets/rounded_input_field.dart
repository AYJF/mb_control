import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

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
          borderSide: const BorderSide(width: 1, color: Colors.black),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(width: 1, color: Colors.black),
        ),
        filled: true,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        hintText: hintText,
        fillColor: Colors.white,
        prefixIcon: Icon(
          icon ?? MaterialIcons.email,
          color: Colors.black,
        ),
      ),
    );
  }
}
