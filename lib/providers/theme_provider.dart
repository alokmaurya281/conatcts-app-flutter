import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  void setTheme() {
    // _themeMode = themeMode;
    _isDark = !_isDark;
    notifyListeners();
  }
}
