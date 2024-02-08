import 'package:auth/auth/ui/widgets/common_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController passwordController;
  final String textFiedlname;

  const PasswordTextField({required this.passwordController,required this.textFiedlname, super.key});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  String? _errorMsg;
  bool obscurePassword = true;
  IconData iconOpenPassword = CupertinoIcons.lock_circle_fill;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CommontTextField(
        controller: widget.passwordController,
        hintText: widget.textFiedlname,
        obscureText: obscurePassword,
        keyboardType: TextInputType.visiblePassword,
        prefixIcon: const Icon(Icons.lock),
        errorMsg: _errorMsg,
        validator: (val) {
          if (val!.isEmpty) {
            return 'Empty';
          } else if (!RegExp(
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
              .hasMatch(val)) {
            return 'Не подейдет';
          }
          return null;
        },
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscurePassword = !obscurePassword;
              if (obscurePassword) {
                iconOpenPassword = CupertinoIcons.lock_circle_fill;
              } else {
                iconOpenPassword = CupertinoIcons.lock_open_fill;
              }
            });
          },
          icon: Icon(iconOpenPassword),
        ),
      ),
    );
  }
}
