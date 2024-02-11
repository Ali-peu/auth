import 'package:auth/auth/ui/pages/app_first_screen/app_first_screen.dart';

import 'package:auth/auth/ui/pages/home_page/home_page.dart';
import 'package:auth/auth/ui/pages/email_or_phone_page/email_or_phone_page.dart';
import 'package:auth/auth/ui/pages/register_page.dart/register_data_page.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final routes = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: AppFirstScreenProvider()),
  '/email_or_phone_number_data': (_) =>
      const MaterialPage(child: EmailOrPhonePageProvider()),
  '/email_or_phone_number_data/:email': (routeData) {
    final email = routeData.pathParameters['email'] ?? ' ';
    return MaterialPage(child: RegisterDataPageProvider(email: email));
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
    routedDelegate: RoutemasterDelegate(routesBuilder: (context) => routes),
    routeInformationParser: const RoutemasterParser(),
  );
}
