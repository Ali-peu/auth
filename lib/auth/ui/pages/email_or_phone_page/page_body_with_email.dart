import 'package:auth/auth/ui/widgets/common_text_field.dart';

import 'package:flutter/material.dart';

class PageBodyWithEmail extends StatefulWidget {
  const PageBodyWithEmail({Key? key}) : super(key: key);

  @override
  State<PageBodyWithEmail> createState() => _PageBodyWithEmailState();
}

class _PageBodyWithEmailState extends State<PageBodyWithEmail> {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return emailTextField();
  }

  CommontTextField emailTextField() {
    return CommontTextField(
      controller: emailController,
      hintText: 'Email',
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.alternate_email),
      validator: (val) {
        if (val!.isEmpty) {
          return 'Empty';
        }
        return null;
      },
    );
  }
}
