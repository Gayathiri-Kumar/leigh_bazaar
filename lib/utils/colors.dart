import 'package:flutter/material.dart';

const Color darkblue = Color(0xFF303F60);
const Color blue = Color(0xFF0C54BE);
const Color white = Color(0xFFF5F9FD);
const Color lightblue = Color(0xFFCED3DC);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF0C54BE),
  onPrimary: Color(0xFF303F60),
  secondary: Color(0xFFCED3DC),
  onSecondary: Color(0xFFFFFFFF),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  shadow: Color(0xFF000000),
  outlineVariant: Color(0xFFC2C8BC),
  surface: Color(0xFFF9FAF3),
  onSurface: Color(0xFF1A1C18),
);
ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
);
