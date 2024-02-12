import 'package:auth/auth/ui/pages/home_page/home_page.dart';
import 'package:auth/auth/ui/pages/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpApp extends StatelessWidget {
  const UpApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePageProvider();
          } else {
            return const LoginScreen();
          }
        });
  }
}
