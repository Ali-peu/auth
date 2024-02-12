import 'package:auth/auth/bloc/sign/sign_bloc.dart';

import 'package:auth/auth/data/validator.dart';
import 'package:auth/auth/ui/pages/sign_with_user_data_page/widgets/sign_with_user_data_form.dart';

import 'package:auth/auth/ui/widgets/custom_text_field.dart';
import 'package:auth/auth/ui/widgets/custom_container.dart';
import 'package:auth/auth/ui/widgets/password_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignWithUserDataPage extends StatelessWidget {
  const SignWithUserDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignBloc(),
      child: const SignWithUserDataForm(),
    );
  }
}
