import 'package:auth/auth/bloc/login/login_bloc.dart';
import 'package:auth/auth/bloc/sign/sign_bloc.dart';
import 'package:auth/auth/bloc/sign_or_login/sign_or_login_bloc.dart';
import 'package:auth/auth/ui/login_page/login_form.dart';
import 'package:auth/auth/ui/sign_page/sign_form.dart';
import 'package:auth/auth/ui/widgets/google_login_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class AuthPageProvider extends StatelessWidget {
  const AuthPageProvider({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignOrLoginBloc(),
      child: const AuthPage(),
    );
  }
}

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: BlocBuilder<SignOrLoginBloc, SignOrLoginState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(children: [
            // Переделай в tabs от RouteMaster не самая хорошая реализация больших экранов таким образом
            // И плюсом избавишься от лишнего блока.
            (state.pageStatus == PageStatus.login)
                ? BlocProvider(
                    create: (context) => LoginBloc(),
                    child: const LoginForm(),
                  )
                : BlocProvider(
                    create: (context) => SignBloc(),
                    child: const SignForm(),
                  ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                  onTap: () =>
                      context.read<SignOrLoginBloc>().add(ChangePageEvent()),
                  child: const Text('ChangePage')),
            ),
            const Divider(),
            BlocProvider(
                create: (context) => LoginBloc(),
                child: const GoogleLoginInButton())
          ]),
        );
      },
    )));
  }
}
