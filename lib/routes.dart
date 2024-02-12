import 'dart:developer';

import 'package:auth/auth/ui/pages/sign_page/sign_page.dart';
import 'package:auth/auth/ui/pages/forgot_password_page/forgot_passsword_page.dart';

import 'package:auth/auth/ui/pages/home_page/home_page.dart';
import 'package:auth/auth/ui/pages/sign_with_user_data_page/sign_with_user_data_page.dart';
import 'package:auth/auth/ui/pages/login_screen/login_screen.dart';
import 'package:auth/auth/ui/pages/fill_users_data_page/fill_users_data_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final routes = RouteMap(routes: {
  '/': (_) =>  const MaterialPage(child: HomePage()),
  '/login_page': (_) => const MaterialPage(child: LoginScreen()),
  '/sign_page': (_) => const MaterialPage(child: SignPageProvider()),
  '/forgot_password': (_) =>
      const MaterialPage(child: ForgotPassswordPage()), // TODO
  '/sign_with_user_data': (_) =>
      const MaterialPage(child: SignWithUserDataPage()),
  '/fill_users_data/:email': (routeData) {
    final email = routeData.pathParameters['email'] ?? ' ';

    return MaterialPage(child: FillUsersDataPage(email: email));
  },
  '/home': (_) => const MaterialPage(child: HomePageProvider()),
});

class App extends MaterialApp {
  const App({
    super.key,
    required RouterDelegate<Object> routedDelegate,
    required RouteInformationParser<Object> routeInformationParser,
  }) : super.router(
            routerDelegate: routedDelegate,
            routeInformationParser: routeInformationParser);

  @override
  bool get debugShowCheckedModeBanner => false;
}

App startApp() {
  return App(
    routedDelegate: RoutemasterDelegate(routesBuilder: (context) {
      log("Its start APP", name: 'Start APP');
      return routes;
    }),
    routeInformationParser: const RoutemasterParser(),
  );
}
