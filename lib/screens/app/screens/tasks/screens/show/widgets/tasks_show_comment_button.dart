import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/features/tasks/models/task.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class TasksShowCommentButton extends StatelessWidget {
  const TasksShowCommentButton({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushRoute(CommentsRoute(taskId: task.id)),
      borderRadius: BorderRadius.circular(mediumValue),
      child: Ink(
        padding: largePadding,
        decoration: BoxDecoration(
          color: context.container,
          borderRadius: mediumRadius,
        ),
        child: Row(
          spacing: mediumValue,
          children: [
            const Icon(Icons.comment),
            Text(
              context.l10n.task_show_comments,
              style: context.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
