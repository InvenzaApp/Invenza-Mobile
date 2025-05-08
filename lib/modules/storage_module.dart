import 'dart:ui';

import 'package:app/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageModule{
  final prefs = inject<SharedPreferences>();
  final _localeKey = 'locale';

  void saveLocale(Locale locale){
    prefs.setString(_localeKey, locale.languageCode);
  }

  Locale getLocale(){
    final languageCode = prefs.getString(_localeKey);
    return Locale(languageCode ?? 'pl');
  }
}
