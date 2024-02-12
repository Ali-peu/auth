import 'package:auth/auth/data/firebase_user_settings.dart';
import 'package:auth/auth/ui/widgets/custom_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class HomePageProvider extends StatelessWidget {
  const HomePageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomContainer(
              child: FutureBuilder(
                  future: FirebaseUserSettings().getUserInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      if (snapshot.data == null) {
                        return const Text('null');
                      } else {
                        return Text(snapshot.data?['fullName'] ?? 'Not Found');
                      }
                    } else {
                      return const Text('Unfound');
                    }
                  })),
          CustomContainer(
              child: TextButton(
            child: const Text('Log Out'),
            onPressed: () {
              setState(() {
                FirebaseAuth.instance.signOut();
                Routemaster.of(context).replace('/login_page');
              });
            },
          )),
          if (FirebaseAuth.instance.currentUser == null)
            CustomContainer(
                child: TextButton(
              child: const Text('Log In'),
              onPressed: () {
                Routemaster.of(context).replace('/login_page');
              },
            )),
        ],
      ),
    );
  }
}
