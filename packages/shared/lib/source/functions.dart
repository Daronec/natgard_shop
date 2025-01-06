import 'dart:convert';

import 'package:intl/intl.dart' as intl;
import 'package:shared/imports.dart';

/// PreRun function
Future preRunFunction() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: AppColors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Preferences.init();
}

bool isFlutterLocalNotificationsInitialized = false;

/// Function for opening web pages
Future<void> openWeb({required String url}) async {
  final Uri uri = Uri.parse(url);
  await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );
}

/// Customizable toast
void showMessage({
  required String message,
  required PageState type,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: kIsWeb ? ToastGravity.TOP_RIGHT : ToastGravity.TOP,
    timeInSecForIosWeb: 3,
    backgroundColor: getMessageColor(type),
    textColor: Colors.white,
    fontSize: 16,
    webBgColor: getMessageHexColor(type),
  );
}

void showMessageChat({
  required String message,
  required BuildContext context,
  Widget? icon,
}) {
  final theme = Theme.of(context);
  FToast fToast = FToast();
  fToast.init(context);
  fToast.showToast(
    child: Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 86),
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 13),
              child: icon,
            ),
          Text(
            message,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    ),
    gravity: ToastGravity.BOTTOM,
  );
}

Color getMessageColor(PageState type) {
  switch (type) {
    case PageState.error:
      return AppColors.error;
    case PageState.success:
      return AppColors.primary;
    case PageState.info:
      return AppColors.lightBlue;
    case PageState.isEmpty:
    case PageState.hasData:
    case PageState.load:
    default:
      return AppColors.error;
  }
}

String getMessageHexColor(PageState type) {
  switch (type) {
    case PageState.error:
      return 'linear-gradient(to right, #ff0000, #ff5050)';
    case PageState.success:
      return "linear-gradient(to right, #00b09b, #96c93d)";
    case PageState.info:
      return 'linear-gradient(to right, #33ccff, #00ffff)';
    case PageState.isEmpty:
    case PageState.hasData:
    case PageState.load:
    default:
      return 'linear-gradient(to right, #ff0000, #ff0000)';
  }
}

/// Function get image device
Future<XFile?> getImage() async {
  final image = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 40,
  );
  if (image == null) {
    return null;
  } else {
    return image;
  }
}

String diffTime({
  required BuildContext context,
  required DateTime date,
}) {
  String time = '';
  if (DateTime.now().difference(date).inDays < 366) {
    time = '${DateTime.now().difference(date).inDays} дней';
  }
  if (DateTime.now().difference(date).inHours < 24) {
    time = '${DateTime.now().difference(date).inHours} часа';
  }
  if (DateTime.now().difference(date).inMinutes < 60) {
    time = '${DateTime.now().difference(date).inMinutes} минут';
  }
  return time;
}

Future<void> openUrl(String link) async {
  final Uri url = Uri.parse(link);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

List<String> extractHashtags(String text) {
  var hashtags = <String>[];
  var words = text.contains('\n') ? text.split('\n') : text.split(' ');
  for (var word in words) {
    if (word.startsWith('#')) {
      hashtags.add(word.substring(0));
    }
  }
  return hashtags;
}

void showCleanHistory({
  required BuildContext context,
  required Function() onClear,
}) async {
  await showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    elevation: 0,
    useSafeArea: true,
    builder: (ctx) {
      final theme = Theme.of(context);
      return Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 58,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 122,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    child: Text(
                      'Действительно хотите очистить историю?\nОтменить действие невозможно',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: 12,
                        color: AppColors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.background,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      onClear();
                    },
                    child: SizedBox(
                      height: 57,
                      child: Center(
                        child: Text(
                          'Очистить историю',
                          style: theme.textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Container(
                height: 57,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Center(
                  child: Text(
                    'Отмена',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showDeleteChat({
  required BuildContext context,
  required Function() onDelete,
}) async {
  await showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    elevation: 0,
    useSafeArea: true,
    builder: (ctx) {
      final theme = Theme.of(context);
      return Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 58,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 122,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    child: Text(
                      'Действительно хотите удалить чат?\nОтменить действие невозможно',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: 12,
                        color: AppColors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.background,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      onDelete();
                    },
                    child: SizedBox(
                      height: 57,
                      child: Center(
                        child: Text(
                          'Удалить чат',
                          style: theme.textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Container(
                height: 57,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Center(
                  child: Text(
                    'Отмена',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

/// Длительность видео для эскизов
String getTime(int seconds) {
  int days = seconds ~/ (24 * 3600);
  int hours = (seconds % (24 * 3600)) ~/ 3600;
  int minutes = ((seconds % 3600) ~/ 60);
  int sec = seconds % 60;

  String time = '${days.toString().padLeft(2, '0') == '00' ? '' : '${days.toString().padLeft(2, '0')}:'}'
      '${hours.toString().padLeft(2, '0') == '00' ? '' : '${hours.toString().padLeft(2, '0')}:'}'
      '${minutes.toString().padLeft(2, '0')}:'
      '${sec.toString().padLeft(2, '0') == '00' ? '' : sec.toString().padLeft(2, '0')}';

  return time;
}

Future<bool> storagePermission() async {
  final DeviceInfoPlugin info = DeviceInfoPlugin(); // import 'package:device_info_plus/device_info_plus.dart';
  final AndroidDeviceInfo androidInfo = await info.androidInfo;
  debugPrint('releaseVersion : ${androidInfo.version.release}');
  final int androidVersion = int.parse(
      androidInfo.version.release.contains('.') ? androidInfo.version.release[0] : androidInfo.version.release);
  bool havePermission = false;

  if (androidVersion >= 13) {
    final request = await [
      Permission.videos,
      Permission.photos,
      //..... as needed
    ].request(); //import 'package:permission_handler/permission_handler.dart';

    havePermission = request.values.every((status) => status == PermissionStatus.granted);
  } else {
    final status = await Permission.storage.request();
    havePermission = status.isGranted;
  }

  if (!havePermission) {
    // if no permission then open app-setting
    await openAppSettings();
  }

  return havePermission;
}

// Функция для определения длины текста в пикселях на dart
int textWidth(
  String text,
  TextStyle style,
  double fontSize,
) {
  // Создаем текстовый виджет для расчета ширины текста
  final textSpan = TextSpan(
    text: text,
    style: style.copyWith(fontSize: fontSize),
  );
  final textPainter = TextPainter(
    text: textSpan,
    maxLines: 1,
    textDirection: TextDirection.ltr,
  );
  textPainter.layout(minWidth: 0, maxWidth: double.infinity);

  // Возвращаем ширину текста в пикселях
  return textPainter.width.toInt();
}

String timeLeft(int totalHours) {
  if (totalHours < 0) {
    return "";
  }

  int days = totalHours ~/ 24;
  int hours = totalHours % 24;

  String result = "";

  if (days > 0) {
    result += "$days ${(days).numEnding(['день', 'дня', 'дней'])}";
    result += " ";
  }

  if (hours > 0) {
    result += "$hours ${(hours).numEnding(['час', 'часа', 'часов'])}";
  }

  if (days == 0 && hours == 0) {
    return '';
  }

  return result;
}

List<Color> getAvatarGradient(int countLevel) {
  switch (countLevel) {
    case (1):
      return gradientColorsBlue;
    case (2):
      return gradientColorsPink;
    case (3):
      return gradientColorsGreen;
    case (4):
      return gradientColorsOrange;
    case (5):
      return gradientColorsYellow;
    default:
      return gradientColorsBlue;
  }
}

Future<void> tryCatcher(Function data, Function(String) errorCallback) async {
  try {
    await data();
  } on DioException catch (ex) {
    String error =
        (ex.response?.data.runtimeType == String ? jsonDecode(ex.response?.data) : ex.response?.data)?["message"]
                .toString() ??
            '';
    errorCallback(error);
  } catch (ex) {
    errorCallback(ex.toString());
  }
}

int getTextWidth(
  String text,
  TextStyle style,
  BuildContext context,
) {
  final MediaQueryData data = MediaQuery.of(context);
  // Создаем текстовый виджет для расчета ширины текста
  final textSpan = TextSpan(
    text: text,
    style: style,
  );
  final textPainter = TextPainter(
    text: textSpan,
    locale: const Locale('ru'),
    textDirection: TextDirection.ltr,
    textScaleFactor: data.textScaleFactor,
  );
  textPainter.layout(
    minWidth: 0,
    maxWidth: data.size.width,
  );

  // Возвращаем ширину текста в пикселях
  return (textPainter.width + text.length * 1.2).toInt();
}
