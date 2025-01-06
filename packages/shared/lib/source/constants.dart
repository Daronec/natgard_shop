
import '../imports.dart';

const baseUrl = "https://parkingmap.ru/";
const clientService = 'client/';
const secretKey = "mnvbpinrbp-wpirnvp-i-3892894f2nwkdlvfmc";

UserModel? user;

List<String> videoIds = [
  'UJZx8Zv5mPA',
  'MfuO96HDf1I',
  'F0ryv8GkBDc',
  'ow0THvd6MTU',
  'YB4nGUsaCRE',
  'uGePi2S_yQc',
  'tBMQglpKxA0',
  'yCtJL-E_LMw',
];
List<String> videoCodes = [
  """
  <iframe style="width: 100%; height: 100%" src="https://www.youtube.com/embed/UJZx8Zv5mPA?si=blhuZeOMNUcXWzuJ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
  """,
  """
  <iframe style="width: 100%; height: 100%" src="https://www.youtube.com/embed/MfuO96HDf1I?si=K506KpXuJXs0f1Nt" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
  """,
  """
  <iframe style="width: 100%; height: 100%" src="https://www.youtube.com/embed/F0ryv8GkBDc?si=gmq0NlyhUqoSXmME" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
  """,
];

RegExp timeRegex = RegExp('^([01]\d|2[0-3]):([0-5]\d):([0-5]\d)');
RegExp timeShortRegex = RegExp('^([01][0-9]|2[0-3]):[0-5][0-9]');

/// Type for Flutter Toast
enum PageState {
  error,
  success,
  info,
  isEmpty,
  hasData,
  load,
}

/// Navigation bar item type
enum IconsType {
  youtube,
  catalog,
  audio,
  profile,
  users,
}



List<Color> gradientColors = const [
  AppColors.darkGreen,
  AppColors.primary,
];
List<Color> gradientColorsDark = const [
  Color(0xff0044af),
  Color(0xff4e02bd),
  Color(0xff7a009c),
  Color(0xff9e1b17),
];
List<Color> gradientColors2 = const [
  Color(0xff67A2FF),
  Color(0xffA86CFF),
  Color(0xffD339FF),
  Color(0xffFF746F),
];
List<Color> gradientColors3 = const [
  Color(0xff8CB8FF),
  Color(0xffCCAAFF),
  Color(0xffE382FF),
  Color(0xffFF746F),
];
List<Color> gradientColorsBlue = const [
  Color(0xff1842E4),
  Color(0xff2366F2),
  Color(0xff2D85FE),
  Color(0xff45F8FF),
];

List<Color> gradientColorsPink = const [
  Color(0xffBC59D6),
  Color(0xffD65ACF),
  Color(0xffE95FAF),
  Color(0xffF161A2),
];

List<Color> gradientColorsGreen = const [
  Color(0xff5CB04F),
  Color(0xff4EB264),
  Color(0xff4CBA6B),
  Color(0xff53C2C9),
];

List<Color> gradientColorsOrange = const [
  Color(0xffD65959),
  Color(0xffD6705A),
  Color(0xffE9915F),
  Color(0xffF1AF61),
];

List<Color> gradientColorsYellow = const [
  Color(0xffD28F2A),
  Color(0xffD6B339),
  Color(0xffD9B537),
  Color(0xffD99443),
];


