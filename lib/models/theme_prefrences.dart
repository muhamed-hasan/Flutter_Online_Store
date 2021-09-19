import 'package:shared_preferences/shared_preferences.dart';

class ThemePrefrences {
  static const THEME_STATUS = 'THEME_STATUS';

  setTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getThemePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}
