import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formattedDateTime(BuildContext context){
    final locale = Localizations.localeOf(context).toString();

    final date = DateFormat.yMMMd(locale).format(this);
    final time = DateFormat.Hm(locale).format(this);

    return '$date, $time';
  }
}
