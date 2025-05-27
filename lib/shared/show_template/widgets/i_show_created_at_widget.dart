import 'package:app/extensions/date_time_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IShowCreatedAtWidget extends StatelessWidget {
  const IShowCreatedAtWidget({required this.dateTime, super.key});

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: smallValue,
      children: [
        Icon(
          Icons.watch_later_outlined,
          size: xLargeValue,
        ),
        Text(
          dateTime.formattedDateTime(context),
          style: context.bodyMedium,
        ),
      ],
    );
  }
}
