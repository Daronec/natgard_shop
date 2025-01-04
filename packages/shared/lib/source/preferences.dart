import 'package:shared/imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<void> clear() async {
    preferences!.remove(Keys.accessToken);
    preferences!.remove(Keys.refreshToken);
  }

  // static Future<void> saveAccessToken(String token) async {
  //   await preferences!.setString(Keys.accessToken, token);
  // }

  static Future<void> removeKey(String key) async {
    await preferences!.remove(key);
  }

  // static String? loadAccessToken() {
  //   if (preferences!.containsKey(Keys.accessToken)) {
  //     final token = preferences!.getString(Keys.accessToken);
  //     return token;
  //   }
  //   return null;
  // }

  static String? loadFirebaseToken() {
    if (preferences!.containsKey(Keys.firebaseToken)) {
      final token = preferences!.getString(Keys.firebaseToken);
      return token;
    }
    return null;
  }

  static Future<void> deleteAccessToken() async {
    preferences!.remove(Keys.accessToken);
  }

  static Future<void> deleteRefreshToken() async {
    preferences!.remove(Keys.refreshToken);
  }

  static Future<void> saveRefreshToken(String token) async {
    await preferences!.setString(Keys.refreshToken, token);
  }

  static String? loadRefreshToken() {
    return preferences!.containsKey(Keys.refreshToken)
        ? preferences!.getString(Keys.refreshToken)
        : '';
  }

  static Future<void> saveTokenSession(DateTime tokenSession) async {
    await preferences!.setString(Keys.tokenSession, tokenSession.toString());
  }

  static Future<void> deleteTokenSession() async {
    await preferences!.remove(Keys.tokenSession);
  }

  static String? loadTokenSession() {
    return preferences!.containsKey(Keys.tokenSession)
        ? preferences!.getString(Keys.tokenSession)
        : '';
  }

  static Future<void> setStringByKey(String key, String str) async {
    await (preferences ?? await SharedPreferences.getInstance())
        .setString(key, str);
  }

  static String? getStringByKey(String key) {
    return preferences!.containsKey(key) ? preferences!.getString(key) : null;
  }

  static List<String>? getListByKey(String key) {
    return preferences!.containsKey(key)
        ? preferences!.getStringList(key)
        : null;
  }

  static Future<void> setListByKey(String key, List<String> list) async {
    await preferences!.setStringList(key, list);
  }

  static Future<void> setIntByKey(String key, int value) async {
    await preferences!.setInt(key, value);
  }

  static int? getIntByKey(String key) {
    return preferences!.containsKey(key) ? preferences!.getInt(key) : null;
  }

  static bool getBoolByKey(String key) {
    return preferences!.containsKey(key) ? preferences!.getBool(key)! : true;
  }

  static bool isFirstRun() {
    return preferences!.containsKey(Keys.isFirstRun)
        ? preferences!.getBool(Keys.isFirstRun)!
        : true;
  }

  static Future<void> setFirstRun() {
    return preferences!.setBool(Keys.isFirstRun, false);
  }

  static Future<void> setBoolByKey(String key, bool value) async {
    await preferences!.setBool(key, value);
  }

  static Future<bool> deleteByKey(String key) async {
    return await preferences!.remove(key);
  }

  static Future<void> saveFontSize(double size) async {
    await preferences!.setDouble(Keys.fontSize, size);
  }

  static double? loadFontSize() {
    return preferences!.containsKey(Keys.fontSize)
        ? preferences!.getDouble(Keys.fontSize)
        : 14;
  }
}
