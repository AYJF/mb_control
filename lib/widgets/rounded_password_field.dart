import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mb_control/tools/color_hex.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String? Function(String? value)? validator;

  const RoundedPasswordField({
    Key? key,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.center,
      validator: widget.validator,
      style: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w300,
        fontSize: 12,
      ),
      obscureText: isObscureText,
      onChanged: widget.onChanged,
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
          hintText: "Password",
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isObscureText = !isObscureText;
                });
              },
              icon: Icon(
                isObscureText
                    ? MaterialCommunityIcons.eye_off_outline
                    : MaterialCommunityIcons.eye_outline,
                size: 20,
                color: HexColor('#C2CFF0'),
              )),
          fillColor: HexColor('#FFFFFF'),
          prefixIcon: Icon(
            Entypo.lock,
            color: HexColor('#C2CFF0'),
          )),
    );
  }
}
