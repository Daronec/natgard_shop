import 'package:shared/imports.dart';

TextInputType switchInputType(TextFieldType fieldType) {
  switch (fieldType) {
    case TextFieldType.phoneNumber:
    case TextFieldType.number:
      return defaultTargetPlatform == TargetPlatform.iOS
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.number;

    case TextFieldType.date:
      return TextInputType.number;

    case TextFieldType.name:
      return TextInputType.name;

    case TextFieldType.doubleSaleChat:
      return TextInputType.number;

    default:
      return TextInputType.text;
  }
}
