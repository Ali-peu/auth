import 'package:auth/auth/bloc/login/login_bloc.dart';
import 'package:auth/auth/ui/widgets/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Form(
            child: Column(
          children: [
            CommontTextField(
              controller: emailController,
              hintText: 'Phone number',
              obscureText: false,
              keyboardType: TextInputType.name,
              suffixIcon: const Icon(Icons.phone),
            ),
            CommontTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
              keyboardType: TextInputType.none,
              prefixIcon: const Icon(Icons.password),
              suffixIcon: const Icon(Icons.lock),
            ),
            ElevatedButton(
                onPressed: () {
                  state.loginStatus != LoginStatus.loading
                      ? context.read<LoginBloc>().add(LoginButtonPressed(
                          email: emailController.text,
                          password: passwordController.text))
                      : null;
                },
                child: const Text('Login'))
          ],
        ));
      },
    );
  }
}
