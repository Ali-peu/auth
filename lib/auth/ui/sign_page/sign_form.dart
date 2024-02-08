import 'package:auth/auth/bloc/sign/sign_bloc.dart';
import 'package:auth/auth/ui/widgets/common_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            CommontTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                suffixIcon: const Icon(Icons.alternate_email)),
            CommontTextField(
                controller: nameController,
                hintText: 'Name',
                obscureText: false,
                keyboardType: TextInputType.name,
                suffixIcon: const Icon(Icons.person)),
            CommontTextField(
              controller: phoneNumberController,
              hintText: 'Phone number',
              obscureText: false,
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(Icons.phone),
            ),
            CommontTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
              keyboardType: TextInputType.none,
              prefixIcon: const Icon(Icons.password),
              suffixIcon: const Icon(Icons.lock),
            ),
            CommontTextField(
              controller: repeatPasswordController,
              hintText: 'Repeat password',
              obscureText: true,
              keyboardType: TextInputType.none,
              prefixIcon: const Icon(Icons.password),
              suffixIcon: const Icon(Icons.lock),
            ),
            ElevatedButton(
                onPressed: () {
                  if (passwordController.text ==
                          repeatPasswordController.text &&
                      formKey.currentState!.validate()) {
                    context.read<SignBloc>().add(SignButtonPressed(
                        userName: nameController.text,
                        phoneNumber: phoneNumberController.text,
                        password: passwordController.text,
                        email: emailController.text));
                  } else {
                    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                        const SnackBar(
                            content: Text('The password doesnt equal')));
                  }
                },
                child: const Text('Sign'))
          ],
        ));
  }
}
