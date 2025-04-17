import 'package:flutter/material.dart';

extension TextExtension on BuildContext{
  TextStyle get displayLarge => TextTheme.of(this).displayLarge!;
  TextStyle get displayMedium => TextTheme.of(this).displayMedium!;
  TextStyle get displaySmall => TextTheme.of(this).displaySmall!;
  TextStyle get headlineLarge => TextTheme.of(this).headlineLarge!;
  TextStyle get headlineMedium => TextTheme.of(this).headlineMedium!;
  TextStyle get headlineSmall => TextTheme.of(this).headlineSmall!;
  TextStyle get titleLarge => TextTheme.of(this).titleLarge!;
  TextStyle get titleMedium => TextTheme.of(this).titleMedium!;
  TextStyle get titleSmall => TextTheme.of(this).titleSmall!;
  TextStyle get bodyLarge => TextTheme.of(this).bodyLarge!;
  TextStyle get bodyMedium => TextTheme.of(this).bodyMedium!;
  TextStyle get bodySmall => TextTheme.of(this).bodySmall!;
  TextStyle get labelLarge => TextTheme.of(this).labelLarge!;
  TextStyle get labelMedium => TextTheme.of(this).labelMedium!;
  TextStyle get labelSmall => TextTheme.of(this).labelSmall!;
}
