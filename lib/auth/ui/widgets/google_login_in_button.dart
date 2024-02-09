import 'dart:developer';

import 'package:auth/auth/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class GoogleLoginInButton extends StatelessWidget {
  const GoogleLoginInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.loginStatus == LoginStatus.success) {
          Routemaster.of(context).push("/home");
        }
        if (state.loginStatus == LoginStatus.failure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.result)));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return GestureDetector(
              onTap: () {
                context.read<LoginBloc>().add(GoogleSingInPressed());
              },
              child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.g_mobiledata,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )));
        },
      ),
    );
  }
}
