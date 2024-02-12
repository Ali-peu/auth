import 'package:auth/auth/bloc/login/login_bloc.dart';
import 'package:auth/auth/ui/pages/login_screen/widgets/login_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              child: BlocProvider(
                  create: (context) => LoginBloc(),
                  child: const LoginScreenBody())),
        ));
  }
}
