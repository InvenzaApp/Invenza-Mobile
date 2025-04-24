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
      padding: smallPadding,
      decoration: BoxDecoration(
          color: task.status.color,
          borderRadius: mediumRadius,
      ),
      child: Text(
        task.status.getName(context),
        style: context.bodySmall.copyWith(color: Colors.white),
      ),
    );
  }
}
