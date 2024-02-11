import 'package:auth/auth/bloc/sign/sign_bloc.dart';
import 'package:auth/auth/data/validator.dart';
import 'package:auth/auth/ui/widgets/common_text_field.dart';
import 'package:auth/auth/ui/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class RegisterDataPageProvider extends StatelessWidget {
  final String email;
  const RegisterDataPageProvider({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignBloc(),
      child: RegisterDataPage(email: email),
    );
  }
}

class RegisterDataPage extends StatefulWidget {
  final String email;
  const RegisterDataPage({required this.email, super.key});

  @override
  State<RegisterDataPage> createState() => _RegisterDataPageState();
}

class _RegisterDataPageState extends State<RegisterDataPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignBloc, SignState>(
      builder: (context, state) {
        return BlocListener<SignBloc, SignState>(
          listener: (context, state) {
            if (state.signStatus == SignStatus.success) {
              Routemaster.of(context).push('/home');
            }
            if (state.signStatus == SignStatus.failure) {
              ScaffoldMessenger.maybeOf(context)
                  ?.showSnackBar(SnackBar(content: Text(state.result)));
            }
          },
          child: Scaffold(
            body: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    nameTextField(),
                    // phoneNumberTextField(),
                    PasswordTextField(
                      passwordController: passwordController,
                      repeatPasswordController,
                      textFieldlname: 'Password',
                      fromPageName: 'Sign',
                    ),
                    PasswordTextField(
                      passwordController,
                      passwordController: repeatPasswordController,
                      textFieldlname: 'Repeat Password',
                      fromPageName: 'Sign',
                    ),
                    signButton(state, context)
                  ],
                )),
          ),
        );
      },
    );
  }

  ElevatedButton signButton(SignState state, BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            state.signStatus != SignStatus.loading
                ? context.read<SignBloc>().add(SignButtonPressed(
                      userName: nameController.text,
                      phoneNumber: phoneNumberController.text,
                      password: passwordController.text,
                      email: widget.email,
                    ))
                : null;
          }
        },
        child: state.signStatus == SignStatus.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const Text('Sign'));
  }

  CommontTextField nameTextField() {
    return CommontTextField(
      controller: nameController,
      hintText: 'Name',
      obscureText: false,
      keyboardType: TextInputType.name,
      prefixIcon: const Icon(Icons.person),
      validator: (val) {
        if (val!.isEmpty) {
          return 'Empty';
        }
        return null;
      },
    );
  }

  Widget phoneNumberTextField() {
    return CommontTextField(
        controller: phoneNumberController,
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
