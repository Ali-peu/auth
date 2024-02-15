import 'package:auth/auth/bloc/sign/sign_bloc.dart';
import 'package:auth/auth/ui/widgets/custom_container.dart';
import 'package:auth/auth/ui/widgets/custom_text_field.dart';
import 'package:auth/auth/ui/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class SignWithUserDataForm extends StatefulWidget {
  const SignWithUserDataForm({super.key});

  @override
  State<SignWithUserDataForm> createState() => _SignWithUserDataFormState();
}

class _SignWithUserDataFormState extends State<SignWithUserDataForm> {
  TextEditingController signController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<SignBloc, SignState>(
      listener: (context, state) {
        if (state.signStatus == SignStatus.success) {
          Routemaster.of(context)
              .push('/fill_users_data/${signController.text}');
        }
      },
      child: BlocBuilder<SignBloc, SignState>(
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
                      onPressed: () => formKey.currentState!.validate()
                          ? context.read<SignBloc>().add(SignButtonPressed(
                              password: passwordController.text,
                              signEmail: signController.text))
                          : () {},
                      child: state.signStatus != SignStatus.loading
                          ? const Text('Далее')
                          : const CircularProgressIndicator()),
                )
              ],
            ),
          );
        },
      ),
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
    return CustomTextField.phoneNumberTextField(
      controller: signController,
      validator: (val) {
        if (val!.isEmpty) {
          return 'Empty';
        }
        return null;
      },
      suffixIcon: const SizedBox(),
    );
  }

  Widget emailTextField() {
    return CustomTextField.emailTextField(
      controller: signController,
      validator: (val) {
        if (val!.isEmpty) {
          return 'Empty';
        }
        return null;
      },
      suffixIcon: const SizedBox(),
      textInputFormatter: const [],
    );
  }
}