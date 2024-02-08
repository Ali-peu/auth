import 'package:auth/auth/bloc/sign_or_login/sign_or_login_bloc.dart';
import 'package:auth/auth/ui/login_page/login_form.dart';
import 'package:auth/auth/ui/sign_page/sign_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: BlocBuilder<SignOrLoginBloc, SignOrLoginState>(
      builder: (context, state) {
        return Column(children: [
          (state.pageStatus == PageStatus.login)
              ? const LoginForm()
              : const SignForm(),
          ElevatedButton(
              onPressed: () =>
                  context.read<SignOrLoginBloc>().add(ChangePageEvent()),
              child: Text('Login'))
        ]);
      },
    )));
  }
}
