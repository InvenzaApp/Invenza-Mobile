import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<Locale> get appSupportedLocales => const [
      Locale('pl'),
      Locale('en'),
    ];

List<LocalizationsDelegate<dynamic>> get appLocalizationsDelegates => [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  AppLocalizations.delegate,
];
