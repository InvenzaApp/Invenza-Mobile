import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/features/tasks/models/task.dart';
import 'package:app/screens/app/screens/tasks/cubit/tasks_list_cubit.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TasksListWidget extends StatelessWidget {
  const TasksListWidget({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(mediumValue),
      onTap: () async {
        final cubit = context.read<TasksListCubit>();
        final needUpdate =
            await context.pushRoute(TasksShowRoute(resourceId: task.id));

        if (needUpdate == true) {
          await cubit.fetch();
        }
      },
      child: Ink(
        padding: mediumPadding,
        decoration: BoxDecoration(
          color: context.container,
          borderRadius: mediumRadius,
          border: task.groupsIdList.isEmpty
              ? Border.all(color: context.error)
              : null,
        ),
        child: Row(
          spacing: mediumValue,
          children: [
            Container(
              padding: smallPadding,
              decoration: BoxDecoration(
                color: context.primary,
                borderRadius: smallRadius,
              ),
              child: Icon(
                Icons.task,
                color: context.onPrimary,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: context.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (task.description?.isNotEmpty ?? false)
                    Text(
                      task.description!,
                      style: context.bodyMedium.copyWith(
                        color: context.onSurfaceVariant,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (task.deadline != null)
                    Text(
                      task.deadline!.formattedDateTime,
                      style: context.bodySmall,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  String get formattedDateTime => DateFormat.yMMMd().format(this);
}
