import 'package:auth/auth/bloc/sign/sign_bloc.dart';

import 'package:auth/auth/data/validator.dart';

import 'package:auth/auth/ui/widgets/custom_text_field.dart';
import 'package:auth/auth/ui/widgets/custom_container.dart';
import 'package:auth/auth/ui/widgets/password_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class SignWithUserDataPageProvider extends StatelessWidget {
  const SignWithUserDataPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignBloc(),
      child: const SignWithUserDataPage(),
    );
  }
}

class SignWithUserDataPage extends StatefulWidget {
  const SignWithUserDataPage({super.key});

  @override
  State<SignWithUserDataPage> createState() => _SignWithUserDataPageState();
}

class _SignWithUserDataPageState extends State<SignWithUserDataPage> {
  TextEditingController signController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<SignBloc, SignState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              rowAboveTheFields(state, context),
              if (state.signType == SignType.email) emailTextField(),
              if (state.signType == SignType.phoneNumber)
                phoneNumberTextField(),
              firstPasswordTextField(),
              secondPasswordTextField(),
              CustomContainer(
                child: TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<SignBloc>().add(SignButtonPressed(
                            password: passwordController.text,
                            signEmail: signController.text));
                        Routemaster.of(context)
                            .push('/fill_users_data/:${signController.text}');
                      }
                    },
                    child: const Text('Далее')),
              )
            ],
          ),
        );
      },
    ));
  }

  PasswordTextField secondPasswordTextField() {
    return PasswordTextField(passwordController,
        passwordController: repeatPasswordController,
        textFieldlname: 'Repeat Password',
        fromPageName: 'Sign');
  }

  PasswordTextField firstPasswordTextField() {
    return PasswordTextField(repeatPasswordController,
        passwordController: passwordController,
        textFieldlname: 'Password',
        fromPageName: 'Sign');
  }

  Row rowAboveTheFields(SignState state, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(getLoginTypeinString(state)),
        GestureDetector(
            onTap: () {
              signController.clear();
              context.read<SignBloc>().add(ChangeSignType());
            },
            child: Text(getString(state)))
      ],
    );
  }

  String getLoginTypeinString(SignState state) {
    if (state.signType == SignType.email) {
      return 'Email';
    } else {
      return 'Телефон номер';
    }
  }

  String getString(SignState state) {
    if (state.signType == SignType.email) {
      return 'Продолжить с телефоном';
    } else {
      return 'Продолжить с почтой';
    }
  }

  Widget phoneNumberTextField() {
    return CustomTextField(
        controller: signController,
        textInputFormatter: Validator().maskFormatter,
        hintText: '+7 (###) ###-##-##',
        prefixIcon: const Icon(Icons.call),
        obscureText: false,
        keyboardType: TextInputType.phone,
        validator: (val) {
          if (val!.isEmpty) {
            return "Empty";
          }
          return null;
        });
  }

  CustomTextField emailTextField() {
    return CustomTextField(
      controller: signController,
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
