import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'constants.dart';
import 'types.dart';

MaskTextInputFormatter? switchInputFormat(TextFieldType fieldType) {
  switch (fieldType) {
    case TextFieldType.phoneNumber:
      return Format.phoneFormat;
    case TextFieldType.date:
      return Format.dateFormat;
    // case TextFieldType.number:
    //   return Format.numberFormat;
    case TextFieldType.doubleSaleChat:
      return Format.doubleSaleChat;
    default:
      return null;
  }
}
