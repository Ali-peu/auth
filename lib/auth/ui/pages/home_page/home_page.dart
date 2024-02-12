import 'package:auth/auth/ui/widgets/custom_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePageProvider extends StatelessWidget {
  const HomePageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CustomContainer(
            child: TextButton(
          child: Text('Log Out'),
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
        )),
      ),
    );
  }
}
