import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/features/tasks/models/task.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class TaskStatusWidget extends StatelessWidget {
  const TaskStatusWidget({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: smallValue,
        vertical: xSmallValue,
      ),
      decoration: BoxDecoration(
        color: task.status.surfaceColor,
        borderRadius: xSmallRadius,
      ),
      child: Row(
        spacing: smallValue,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            size: smallValue,
            color: task.status.color,
          ),
          Text(
            task.status.getName(context),
            style: context.bodyMedium.copyWith(color: task.status.color),
          ),
        ],
      ),
    );
  }
}
