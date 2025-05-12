import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formattedDateTime(BuildContext context){
    final locale = Localizations.localeOf(context).toString();

    return DateFormat.yMMMd(locale).format(this);
  }
}
