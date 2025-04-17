import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class LocaleCubit extends HydratedCubit<Locale>{
  LocaleCubit() : super(const Locale('en'));
  static const localeKey = 'locale';

  void changeLocale(Locale locale) => emit(locale);

  @override
  Locale fromJson(Map<String, dynamic> json) {
    final locale = json[localeKey] as String?;
    return locale != null ? Locale(locale) : const Locale('en');
  }

  @override
  Map<String, dynamic>? toJson(Locale state) {
    return { localeKey: state.toString() };
  }
}
