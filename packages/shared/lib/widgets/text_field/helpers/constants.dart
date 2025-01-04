import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Format {
  static final phoneFormat = MaskTextInputFormatter(
    mask: '+7 ### ### ## ##',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );
  static final phoneFormatKG = MaskTextInputFormatter(
    mask: '+### ### ### ###',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );
  static final divisionCode = MaskTextInputFormatter(
    mask: '###-###',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  static final okvedFormat = MaskTextInputFormatter(
    mask: '##.##.##',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  static final doubleSaleChat = MaskTextInputFormatter(
    mask: '#.##',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  static final temperatureFormat = MaskTextInputFormatter(
    mask: '##.#',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  static final numberFormat = MaskTextInputFormatter(
    mask: '################################################',
    filter: {
      "#": RegExp(r'^.+[0-9]'),
    },
  );
  static final dateFormat = MaskTextInputFormatter(
    mask: '##.##.####',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );
  static final timeFormat = MaskTextInputFormatter(
    mask: '## : ##',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );
  static final nameFormat =
      FilteringTextInputFormatter.allow(RegExp("[a-zA-Zа-яА-Я ]"));
}

String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?)*$";

final RegExp emailRegex = RegExp(pattern);
