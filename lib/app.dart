import 'dart:developer';

import 'package:auth/routes.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class App extends MaterialApp {
  const App({
    required RouterDelegate<Object> routedDelegate,
    required RouteInformationParser<Object> routeInformationParser,
    super.key,
  }) : super.router(
            routerDelegate: routedDelegate,
            routeInformationParser: routeInformationParser);

  @override
  bool get debugShowCheckedModeBanner => false;
}

App startApp() {
  return App(
    routedDelegate: RoutemasterDelegate(routesBuilder: (context) {
      log('Its start APP', name: 'Start APP');
      return routes;
    }),
    routeInformationParser: const RoutemasterParser(),
  );
}
