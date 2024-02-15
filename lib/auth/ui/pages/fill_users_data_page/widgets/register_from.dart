import 'package:auth/auth/bloc/sign/sign_bloc.dart';
import 'package:auth/auth/ui/widgets/custom_text_field.dart';
import 'package:auth/auth/ui/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class RegisterFrom extends StatefulWidget {
  final String email;
  const RegisterFrom({required this.email, super.key});

  @override
  State<RegisterFrom> createState() => _RegisterFromState();
}

class _RegisterFromState extends State<RegisterFrom> {
  TextEditingController nameController = TextEditingController();
  TextEditingController someThingController1 = TextEditingController();
  TextEditingController someThingController2 = TextEditingController();
  TextEditingController someThingController3 = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignBloc, SignState>(
      listener: (context, state) {
        if (state.signStatus == SignStatus.success) {
          Routemaster.of(context).push('/home');
        }
      },
      child: BlocBuilder<SignBloc, SignState>(
        builder: (context, state) {
          return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  simpleText(),
                  simpleText1(),
                  simpleText2(),
                  simpleText3(),
                  signElevatedButton(),
                  CustomContainer(
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title:
                                        const Text('Точно хотите пропустить'),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Routemaster.of(context).pop();
                                          },
                                          child: const Text('НЕТ')),
                                      ElevatedButton(
                                          onPressed: () {
                                            Routemaster.of(context).pop();
                                            Routemaster.of(context).replace(
                                                '/home'); // TODO Кнопка назад работатет ANdroid
                                          },
                                          child: const Text('ДА'))
                                    ],
                                  );
                                });
                          },
                          child: const Text('Skip')))
                ],
              ));
        },
      ),
    );
  }

  CustomContainer signElevatedButton() {
    return CustomContainer(
        child: ElevatedButton(
      child: const Text('Далее'),
      onPressed: () {
        context.read<SignBloc>().add(FillUserData(
            userSignEmail: widget.email, updateName: nameController.text));
      },
    ));
  }

 CustomTextField simpleText3() {
    return CustomTextField.simpleText(
      controller: nameController,
      validator: (val) {
        if (val!.isEmpty) {
          return 'Empty';
        }
        return null;
      },
      suffixIcon: const SizedBox(),
      textInputFormatter: const [],
    );
  }

  CustomTextField simpleText2() {
    return CustomTextField.simpleText(
      controller: nameController,
      validator: (val) {
        if (val!.isEmpty) {
          return 'Empty';
        }
        return null;
      },
      suffixIcon: const SizedBox(),
      textInputFormatter: const [],
    );
  }

 CustomTextField simpleText1() {
    return CustomTextField.simpleText(
      controller: nameController,
      validator: (val) {
        if (val!.isEmpty) {
          return 'Empty';
        }
        return null;
      },
      suffixIcon: const SizedBox(),
      textInputFormatter: const [],
    );
  }

  CustomTextField simpleText() {
    return CustomTextField.simpleText(
      controller: nameController,
      validator: (val) {
        if (val!.isEmpty) {
          return 'Empty';
        }
        return null;
      },
      suffixIcon: const SizedBox(),
      textInputFormatter: const [],
    );
  }
}
