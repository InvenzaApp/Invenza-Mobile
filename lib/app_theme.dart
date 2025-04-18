import 'package:flutter/material.dart';

Color get _colorSeed => const Color(0xFF082A5B);

ColorScheme get _lightScheme => ColorScheme.fromSeed(seedColor: _colorSeed);

ColorScheme get _darkScheme =>
    ColorScheme.fromSeed(seedColor: _colorSeed, brightness: Brightness.dark);

InputDecorationTheme get _inputTheme => InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: _lightScheme.secondary,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: _lightScheme.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: _lightScheme.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightScheme.error, width: 2),
      ),
    );

ThemeData get lightTheme => ThemeData(
      colorScheme: _lightScheme,
      inputDecorationTheme: _inputTheme,
    );

ThemeData get darkTheme => ThemeData(
      colorScheme: _darkScheme,
      brightness: Brightness.dark,
      inputDecorationTheme: _inputTheme,
    );
