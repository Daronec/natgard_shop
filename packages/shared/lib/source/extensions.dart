import 'package:intl/intl.dart';
import 'package:shared/imports.dart';

/// Extensions for endings in Russian
/// example of use
/// (year).numEnding(['год', 'года', 'лет'])

extension NumberEnding on int {
  String numEnding(titles) {
    String str = '';
    final cases = [2, 0, 1, 1, 1, 2];
    str = titles[(this % 100 > 4 && this % 100 < 20) ? 2 : cases[(this % 10 < 5) ? this % 10 : 5]];
    return str;
  }
}

extension StringExtension on DateTime {
  String get formatDate {
    String dateFormat = DateFormat("dd MMMM yyyy", 'ru').format(this);
    return dateFormat;
  }

  String get formatNumberDate {
    String dateFormat = DateFormat("dd.MM.yyyy", 'ru').format(this);
    return dateFormat;
  }

  String get chatFormatDate {
    String dateFormat = DateFormat("dd/MM/yyyy в HH:mm", 'ru').format(this);
    return dateFormat;
  }

  String get chatTestFormatDate {
    String dateFormat = DateFormat("dd/MM/yyyy в HH:mm:ss", 'ru').format(this);
    return dateFormat;
  }

  String get formatDateNameDay {
    String dateFormat = DateFormat("EEEE, dd MMMM", 'ru').format(this);
    return dateFormat;
  }

  String get getMonth {
    String dateFormat = DateFormat("MMMM", 'ru').format(this);
    return dateFormat;
  }

  String get formatDateNumber {
    String dateFormat = DateFormat("dd.MM.yyyy").format(this);
    return dateFormat;
  }

  String get sendFormat => '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

  String get getTime {
    final dateString = toIso8601String();
    final dateStringLocal = "${dateString}z";
    final dateLocal = DateTime.parse(dateStringLocal).toLocal();
    String dateFormat = DateFormat("HH:mm").format(dateLocal);
    return dateFormat;
  }

  String get getTimer {
    String dateFormat = DateFormat("HH:mm:ss", 'ru_RU').format(this);
    return dateFormat;
  }

  String get sendDate {
    String dateFormat = DateFormat("dd.MM.yyyy").format(this);
    return dateFormat;
  }

  DateTime timeToDate(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}

extension DateTimeExtension on String {
  DateTime get formatDateToDate {
    List<String> value = split('.');
    DateTime date = DateTime(int.parse(value[2]), int.parse(value[1]), int.parse(value[0]));
    return date;
  }

  DateTime get formatTimeDate {
    DateFormat dateFormat = DateFormat("HH:mm dd.MM.yyyy");
    return dateFormat.parse(this);
  }

  String splitFIO(int index) {
    String value = '';
    List<String> list = split(' ');
    value = list[index];
    return value;
  }
}

extension StringsExtension on String {
  String capitalize() {
    if (length > 1) {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    }
    return this;
  }
}

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}

/// Расширение для получения позиции на экране
extension GlobalPaintBounds on BuildContext {
  Rect? get globalPaintBounds {
    final renderObject = findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}
