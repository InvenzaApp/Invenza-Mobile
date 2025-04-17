import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode>{
  ThemeCubit() : super(ThemeMode.system);
  static const themeKey = 'theme';

  void changeTheme(ThemeMode theme) => emit(theme);

  @override
  ThemeMode fromJson(Map<String, dynamic> json) {
    final theme = json[themeKey] as String?;
    return theme != null ? ThemeMode.values.byName(theme) : ThemeMode.system;
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return { themeKey: state.name };
  }
}
