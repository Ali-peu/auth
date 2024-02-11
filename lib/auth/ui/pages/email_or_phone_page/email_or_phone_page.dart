import 'package:auth/auth/bloc/change_page/change_page_bloc.dart';
import 'package:auth/auth/ui/pages/email_or_phone_page/page_body_with_email.dart';
import 'package:auth/auth/ui/pages/email_or_phone_page/page_body_with_phone.dart';
import 'package:auth/auth/ui/widgets/common_text_field.dart';
import 'package:auth/auth/ui/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class EmailOrPhonePageProvider extends StatelessWidget {
  const EmailOrPhonePageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePageBloc(),
      child: const EmailOrPhonePage(),
    );
  }
}

class EmailOrPhonePage extends StatefulWidget {
  const EmailOrPhonePage({super.key});

  @override
  State<EmailOrPhonePage> createState() => _EmailOrPhonePageState();
}

class _EmailOrPhonePageState extends State<EmailOrPhonePage> {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ChangePageBloc, ChangePageState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(state.pageStatus == PageStatus.firstPage
                      ? 'Email'
                      : 'Номер телефона'),
                  GestureDetector(
                      onTap: () {
                        context
                            .read<ChangePageBloc>()
                            .add(ChangePagePressedEvent());
                      },
                      child: Text(state.pageStatus == PageStatus.firstPage
                          ? 'Продолжить с телефона'
                          : 'Продолжить с email'))
                ],
              ),
              state.pageStatus == PageStatus.firstPage
                  ? const PageBodyWithEmail()
                  : PageBodyWithPhone(formKey: formKey),
              CustomContainer(
                child: TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Routemaster.of(context).push(
                            '/email_or_phone_number_data/:${emailController.text}');
                      }
                    },
                    child: const Text('Далее')),
              )
            ],
          ),
        );
      },
    ));
  }

  CommontTextField emailTextField() {
    return CommontTextField(
      controller: emailController,
      hintText: 'Email',
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.alternate_email),
      validator: (val) {
        if (val!.isEmpty) {
          return 'Empty';
        }
        return null;
      },
    );
  }
}
