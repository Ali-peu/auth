import 'package:auth/auth/ui/auth_page.dart';
import 'package:auth/auth/ui/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

// не смешивай. Файл называется routes.dart а тут и App
final routes = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: AuthPageProvider()),
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
