import 'package:app/extensions/date_time_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IShowDeadlineWidget extends StatelessWidget {
  const IShowDeadlineWidget({required this.deadline, super.key});

  final DateTime deadline;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: smallValue,
      children: [
        Icon(
          Icons.flag_outlined,
          size: xLargeValue,
        ),
        Text(
          deadline.formattedDateTime(context),
          style: context.bodyMedium,
        ),
      ],
    );
  }
}
