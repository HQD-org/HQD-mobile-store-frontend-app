import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreference {
  static SharedPreferences? prefs;
  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future setAccessToken(String value) async {
    await prefs!.setString('token', value);
  }

  static String getAccessToken() {
    return prefs!.getString('token') ?? '0';
  }
}
