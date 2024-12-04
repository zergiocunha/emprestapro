import 'package:emprestapro/common/constants/validation_messages.dart';

class Validator {
  Validator._();

  static String? validateName(String? value) {
    final condition = RegExp(r"((\ *)[\wáéíóúñ]+(\ *)+)+");
    if (value!.isEmpty) {
      return ValidationMessages.name;
    } else if (!condition.hasMatch(value)) {
      return ValidationMessages.invalidName;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final condition = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (value!.isEmpty) {
      return ValidationMessages.email;
    } else if (!condition.hasMatch(value)) {
      return ValidationMessages.invalidEmail;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final condition =
        RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");
    if (value!.isEmpty) {
      return ValidationMessages.password;
    } else if (!condition.hasMatch(value)) {
      return ValidationMessages.invalidPassword;
    }
    return null;
  }

  static String? validatePasswordConfirmation(String? first, String? second) {
    if (first!.isEmpty) {
      return ValidationMessages.repeatPassowrd;
    } else if (second != first) {
      return ValidationMessages.invalidRepeatPassowrd;
    }
    return null;
  }

  static bool isDueTodayOrPast(DateTime dueDate, bool concluded) {
    DateTime today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime formattedDueDate =
        DateTime(dueDate.year, dueDate.month, dueDate.day);
    return formattedDueDate.isBefore(
          today.add(
            const Duration(
              days: 3,
            ),
          ),
        ) &&
        !concluded;
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    // Expressão regular para validar o formato (XX)XXXXX-XXXX
    final regex = RegExp(r'^\(\d{2}\)\d{5}-\d{4}$');
    return regex.hasMatch(phoneNumber);
  }
}
