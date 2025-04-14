import 'package:flutter/material.dart';

Color get _colorSeed => const Color(0xFF082A5B);

ThemeData get lightTheme => ThemeData(
  colorSchemeSeed: _colorSeed,
);

ThemeData get darkTheme => ThemeData(
  colorSchemeSeed: _colorSeed,
  brightness: Brightness.dark,
);
