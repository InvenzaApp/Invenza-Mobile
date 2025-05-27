import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/tasks/models/task.dart';
import 'package:app/shared/widgets/i_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class TasksShowCommentButton extends StatelessWidget {
  const TasksShowCommentButton({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return IButton(
      label: context.l10n.task_show_comments,
      onPressed: () => context.pushRoute(CommentsRoute(taskId: task.id)),
      leadingIcon: Icons.comment_outlined,
    );
  }
}
