import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Validator {
  String? emailCheck(String? email) {
    if (email == null || email.isEmpty) {
      return "Email can't be empty";
    }
    final RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegExp.hasMatch(email)) {
      return 'Проверьте ваш эмейл';
    }
    return null;
  }

  String clearPhoneNumber(String number) {
    String rightNumber =
        '8${number.substring(1, 2)}${number.substring(4, 7)}${number.substring(9, 12)}${number.substring(13, 15)}${number.substring(17)}';
    print(rightNumber);
    return rightNumber;
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.eager);
}
