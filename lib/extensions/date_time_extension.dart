import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get formattedDateTime => DateFormat.yMMMd().format(this);
}
