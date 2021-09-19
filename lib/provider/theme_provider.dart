import 'package:flutter/cupertino.dart';
import 'package:online_store/models/theme_prefrences.dart';

class ThemeProvider with ChangeNotifier {
  final themePrefrences = ThemePrefrences();
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    themePrefrences.setTheme(value);
    notifyListeners();
  }
}
