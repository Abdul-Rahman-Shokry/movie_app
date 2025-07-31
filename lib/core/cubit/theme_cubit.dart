import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For theme management later

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences _prefs;
  static const String _themeKey = 'app_theme';

  ThemeCubit(this._prefs) : super(_loadTheme(_prefs));

  static ThemeMode _loadTheme(SharedPreferences prefs) {
    final String? themeString = prefs.getString(_themeKey);
    if (themeString == 'dark') {
      return ThemeMode.dark;
    } else if (themeString == 'light') {
      return ThemeMode.light;
    }
    return ThemeMode.system; // Default to system theme
  }

  void toggleTheme() {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
      _prefs.setString(_themeKey, 'dark');
    } else {
      emit(ThemeMode.light);
      _prefs.setString(_themeKey, 'light');
    }
  }

  void setTheme(ThemeMode mode) {
    emit(mode);
    _prefs.setString(_themeKey, mode == ThemeMode.dark ? 'dark' : 'light');
  }
}
