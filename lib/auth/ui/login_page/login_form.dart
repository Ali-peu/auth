import 'dart:developer';

import 'package:auth/auth/bloc/login/login_bloc.dart';
import 'package:auth/auth/ui/widgets/common_text_field.dart';
import 'package:auth/auth/ui/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

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
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        log('Is it worker');
        if (state.loginStatus == LoginStatus.success) {
          log('Before pushing to home');
          Routemaster.of(context).push("/home");
        }
        if (state.loginStatus == LoginStatus.failure) {
          ScaffoldMessenger.maybeOf(context)
              ?.showSnackBar(SnackBar(content: Text(state.result)));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
              child: Column(
            children: [
              phoneNumberTextField(),
              PasswordTextField(
                passwordController: passwordController,
                textFiedlname: 'Password',
              ),
              loginButton(state, context)
            ],
          ));
        },
      ),
    );
  }

  ElevatedButton loginButton(LoginState state, BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          state.loginStatus == LoginStatus.loading
              ? null
              : context.read<LoginBloc>().add(LoginButtonPressed(
                  email: emailController.text,
                  password: passwordController.text));
        },
        child: state.loginStatus == LoginStatus.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const Text('Login'));
  }

  CommontTextField phoneNumberTextField() {
    return CommontTextField(
      controller: emailController,
      hintText: 'Email',
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      suffixIcon: const Icon(Icons.phone),
    );
  }
}
