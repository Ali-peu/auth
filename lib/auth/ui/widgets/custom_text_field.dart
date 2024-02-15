import 'package:auth/auth/data/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? textInputFormatter;

  const CustomTextField.simpleText(
      {required this.suffixIcon,
      required this.textInputFormatter,
      required this.controller,
      required this.validator,
      super.key})
      : hintText = 'Name',
        obscureText = false,
        keyboardType = TextInputType.name,
        prefixIcon = const Icon(Icons.person);

  const CustomTextField.emailTextField(
      {required this.suffixIcon,
      required this.textInputFormatter,
      required this.controller,
      required this.validator,
      super.key})
      : hintText = 'Email',
        obscureText = false,
        keyboardType = TextInputType.emailAddress,
        prefixIcon = const Icon(Icons.alternate_email);

  CustomTextField.phoneNumberTextField(
      {required this.suffixIcon,
      required this.controller,
      required this.validator,
      super.key})
      : hintText = '+7 (###) ###-##-##',
        prefixIcon = const Icon(Icons.call),
        obscureText = false,
        keyboardType = TextInputType.phone,
        textInputFormatter = [Validator().maskFormatter];

  const CustomTextField(
      {required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.keyboardType,
      super.key,
      this.suffixIcon,
      this.prefixIcon,
      this.validator,
      this.textInputFormatter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        inputFormatters: textInputFormatter,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
