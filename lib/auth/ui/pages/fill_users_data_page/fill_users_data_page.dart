import 'package:auth/auth/bloc/sign/sign_bloc.dart';
import 'package:auth/auth/ui/pages/fill_users_data_page/widgets/register_from.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FillUsersDataPage extends StatelessWidget {
  final String email;
  const FillUsersDataPage({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: BlocProvider(
          create: (context) => SignBloc(),
          child: RegisterFrom(email: email),
        ));
  }
}
