import 'package:auth/auth/data/validator.dart';
import 'package:auth/auth/ui/widgets/common_text_field.dart';
import 'package:auth/auth/ui/widgets/custom_container.dart';
import 'package:flutter/material.dart';

class PageBodyWithPhone extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const PageBodyWithPhone({required this.formKey, super.key});

  @override
  State<PageBodyWithPhone> createState() => _PageBodyWithPhoneState();
}

class _PageBodyWithPhoneState extends State<PageBodyWithPhone> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController codeFromServerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        phoneNumberTextField(),
        CustomContainer(
            child: Row(
          children: [
            Flexible(
              child: AbsorbPointer(
                absorbing:
                    Validator().checkPhoneNumber(phoneNumberController.text),
                child: codeFromServer(),
              ),
            ),
            TextButton(onPressed: () {}, child: const Text('Отправить код'))
          ],
        ))
      ],
    );
  }

  Widget codeFromServer() {
    return TextFormField(
      controller: codeFromServerController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(20),
        //   borderSide:
        //       BorderSide(color: Theme.of(context).colorScheme.secondary),
        // ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: 'Выведите код',
        hintStyle: TextStyle(color: Colors.grey[500]),
      ),
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
