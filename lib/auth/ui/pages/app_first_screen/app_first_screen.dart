import 'dart:developer';

import 'package:auth/auth/bloc/login/login_bloc.dart';
import 'package:auth/auth/ui/widgets/custom_divider.dart';
import 'package:auth/auth/ui/widgets/registration_button_with_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class AppFirstScreenProvider extends StatelessWidget {
  const AppFirstScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const AppFirstScreen(),
    );
  }
}

class AppFirstScreen extends StatelessWidget {
  const AppFirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Routemaster.of(context).push('/email_or_phone_number_data');
              },
              child: const RegistrationButtonWithPlatform(
                  platformName: 'Вывести телефон или эл. почту',
                  platformaIcon: Icons.person_sharp),
            ),
            const CustomDivider(),
            GestureDetector(
              onTap: () {
                context.read<LoginBloc>().add(GoogleSingInPressed());
              },
              child: const RegistrationButtonWithPlatform(
                  platformName: 'Google', platformaIcon: Icons.g_mobiledata),
            ),
            GestureDetector(
              onTap: () {
                log('We are here add Apple ID login'); //TODO
              },
              child: const RegistrationButtonWithPlatform(
                  platformName: 'AppleID', platformaIcon: Icons.apple),
            )
          ],
        ),
      ),
    );
  }
}
