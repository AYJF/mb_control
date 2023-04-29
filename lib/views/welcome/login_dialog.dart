import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mb_control/services/user_provider.dart';
import 'package:mb_control/tools/color_hex.dart';
import 'package:mb_control/widgets/or_divider.dart';
import 'package:mb_control/widgets/rounded_input_field.dart';
import 'package:mb_control/widgets/rounded_password_field.dart';
import 'package:provider/provider.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const _EmailField(),
          const SizedBox(height: 15),
          const _PasswordField(),
          const SizedBox(height: 40),
          userHndl.isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      userHndl.isLoading = true;

                      final bool isValid = await userHndl.login();
                      userHndl.isLoading = false;
                      if (isValid) Navigator.of(context).pushNamed('/home');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    minimumSize: const Size(300, 50),
                  ),
                  child: const Text(
                    'Login!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
          const SizedBox(height: 18),
          // const OrDivider(),
          // const SizedBox(height: 20),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     SvgPicture.asset('assets/images/shapes/Logo-2.svg'),
          //     SvgPicture.asset('assets/images/shapes/Logo-3.svg'),
          //     SvgPicture.asset('assets/images/shapes/Logo.svg'),
          //   ],
          // )
        ],
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(0, 0, 0, 0.5),
          ),
        ),
        const SizedBox(height: 12),
        RoundedInputField(
          hintText: "Email address",
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                !EmailValidator.validate(value)) {
              return 'Email is not valid';
            }
            return null;
          },
          onChanged: (value) {
            userHndl.email = value;
          },
        ),
      ],
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final UserHndl userHndl = Provider.of<UserHndl>(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Password",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
              ),
              Text(
                'Forgot password?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          RoundedPasswordField(
            validator: (value) {
              if (value == null || value.length <= 6) {
                return 'Please, password must be greater than 6';
              }
              return null;
            },
            onChanged: (value) {
              userHndl.password = value;
            },
          ),
        ]);
  }
}
