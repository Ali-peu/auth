import 'dart:developer';

import 'package:auth/auth/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ForgotPassswordPage extends StatefulWidget {
  const ForgotPassswordPage({super.key});

  @override
  State<ForgotPassswordPage> createState() => _ForgotPassswordPageState();
}

class _ForgotPassswordPageState extends State<ForgotPassswordPage> {
  TextEditingController forgottenPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
              controller: forgottenPasswordController,
              hintText: 'Новый пароль',
              obscureText: false,
              keyboardType: TextInputType.name),
          ElevatedButton(
              onPressed: () {
                //TODO
                log('We are here do something',
                    name: "ForgotPassswordPage ElevatedButton");
              },
              child: const Text('Далее'))
        ],
      ),
    );
  }
}
