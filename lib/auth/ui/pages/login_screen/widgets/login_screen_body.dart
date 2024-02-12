import 'dart:developer';

import 'package:auth/auth/bloc/login/login_bloc.dart';
import 'package:auth/auth/data/validator.dart';
import 'package:auth/auth/ui/widgets/custom_text_field.dart';
import 'package:auth/auth/ui/widgets/custom_divider.dart';
import 'package:auth/auth/ui/widgets/password_text_field.dart';
import 'package:auth/auth/ui/widgets/registration_button_with_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final formKey = GlobalKey<FormState>();
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.loginStatus == LoginStatus.success) {
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
              key: formKey,
              child: Column(
                children: [
                  rowAboveTheFields(state, context),
                  if (state.loginType == LoginType.email) emailTextField(),
                  if (state.loginType == LoginType.phone)
                    phoneNumberTextField(),
                  passwordTextField(),
                  forgotPasswordString(context),
                  elevatedLoginButton(context),
                  const CustomDivider(),
                  googleLoginContainer(context),
                  appleLoginContainer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                        onTap: () {
                          Routemaster.of(context).push('/sign_page');
                        },
                        child: Text('Зарегистрироватся ')),
                  )
                ],
              ));
        },
      ),
    );
  }

  GestureDetector appleLoginContainer() {
    return GestureDetector(
      onTap: () {
        log('We are here add Apple ID login'); //TODO
      },
      child: const RegistrationButtonWithPlatform(
          platformName: 'AppleID', platformaIcon: Icons.apple),
    );
  }

  GestureDetector googleLoginContainer(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<LoginBloc>().add(GoogleSingInPressed());
      },
      child: const RegistrationButtonWithPlatform(
          platformName: 'Google', platformaIcon: Icons.g_mobiledata),
    );
  }

  ElevatedButton elevatedLoginButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          context.read<LoginBloc>().add(LoginButtonPressed(
              email: loginController.text, password: passwordController.text));
        },
        child: const Text('Login'));
  }

  Align forgotPasswordString(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
            onTap: () {
              Routemaster.of(context).push('/forgot_password');
            },
            child: const Text('Забыли пароль? Нажмите сюда',
                style: TextStyle(decoration: TextDecoration.underline))));
  }

  PasswordTextField passwordTextField() {
    return PasswordTextField(null,
        passwordController: passwordController,
        textFieldlname: 'Password',
        fromPageName: 'Login');
  }

  ElevatedButton loginButton(LoginState state, BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            state.loginStatus == LoginStatus.loading
                ? null
                : context.read<LoginBloc>().add(LoginButtonPressed(
                    email: loginController.text,
                    password: passwordController.text));
          }
        },
        child: state.loginStatus == LoginStatus.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const Text('Login'));
  }

  Row rowAboveTheFields(LoginState state, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(getLoginTypeinString(state)),
        GestureDetector(
          onTap: () {
            loginController.clear();
            context.read<LoginBloc>().add(ChangeLoginType());
          },
          child: Text(getString(state)),
        )
      ],
    );
  }

  String getLoginTypeinString(LoginState state) {
    if (state.loginType == LoginType.email) {
      return 'Email';
    } else {
      return 'Телефон номер';
    }
  }

  String getString(LoginState state) {
    if (state.loginType == LoginType.email) {
      return 'Продолжить с телефоном';
    } else {
      return 'Продолжить с почтой';
    }
  }

  CustomTextField emailTextField() {
    return CustomTextField(
      controller: loginController,
      hintText: 'Email',
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      suffixIcon: const Icon(Icons.phone),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Empty';
        }
        return null;
      },
    );
  }

  Widget phoneNumberTextField() {
    return CustomTextField(
        controller: loginController,
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
}
