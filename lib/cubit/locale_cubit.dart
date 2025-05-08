import 'package:app/di.dart';
import 'package:app/modules/storage_module.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class LocaleCubit extends Cubit<Locale>{
  LocaleCubit() : super(const Locale('pl')){
    loadLocale();
  }

  static const localeKey = 'locale';
  final storageModule = StorageModule();

  void changeLocale(Locale locale){
    emit(locale);
    print("LOCALE: ${locale.languageCode}");
    storageModule.saveLocale(locale);
  }

  void loadLocale(){
    final locale = storageModule.getLocale();
    emit(locale);
  }
}
