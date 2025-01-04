import 'package:flutter/material.dart';

import 'constants.dart';
import 'types.dart';

String? switchValidation(
  BuildContext context,
  TextFieldType fieldType,
  String value,
) {
  switch (fieldType) {
    case TextFieldType.email:
      if (value.isEmpty || !emailRegex.hasMatch(value)) {
        return 'Email введён неверно';
      }
      break;
    case TextFieldType.phoneNumber:
      if (value.isEmpty) {
        return "Заполните поле";
      } else if (value.length < 16) {
        return "Телефон указан не полностью";
      }
      break;
    case TextFieldType.date:
      if (value.isEmpty) {
        return "Заполните поле";
      }
      List<String> list = value.split('.');
      if (int.parse(list[0]) > 31) {
        return "Неправильно указан день";
      }
      if (int.parse(list[1]) > 12) {
        return "Неправильно указан месяц";
      }
      if (int.parse(list[2]) > DateTime.now().year) {
        return "Неправильно указан год";
      }
      break;
    case TextFieldType.number:
      if (value.isEmpty) {
        return "Заполните поле";
      }
      break;
    case TextFieldType.password:
      if (value.isEmpty) {
        return "Заполните пароль";
      }
      break;
    default:
      if (value.isEmpty) {
        return null;
      }
      break;
  }
  return null;
}
