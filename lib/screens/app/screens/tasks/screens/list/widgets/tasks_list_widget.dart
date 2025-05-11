import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/core/list/cubit/list_cubit.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/date_time_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/features/tasks/models/task.dart';
import 'package:app/screens/app/screens/tasks/screens/list/widgets/task_status_widget.dart';
import 'package:app/shared/widgets/i_lock_widget.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksListWidget extends StatelessWidget {
  const TasksListWidget({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(mediumValue),
      onTap: () async {
        final cubit = context.read<ListCubit<Task>>();
        final needUpdate =
            await context.pushRoute(TasksShowRoute(resourceId: task.id));

        if (needUpdate == true) {
          await cubit.initialize();
        }
      },
      child: Ink(
        padding: mediumPadding,
        decoration: BoxDecoration(
          color: context.container,
          borderRadius: mediumRadius,
          border: task.groupsIdList.isEmpty
              ? Border.all(color: context.error)
              : Border.all(color: Colors.transparent),
        ),
        child: Row(
          spacing: mediumValue,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TaskStatusWidget(task: task),
                  SizedBox(height: xSmallValue),
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
                    Column(
                      children: [
                        SizedBox(height: mediumValue),
                        Row(
                          spacing: smallValue,
                          children: [
                            Icon(
                              Icons.flag_outlined,
                              size: xLargeValue,
                            ),
                            Text(
                              task.deadline!.formattedDateTime,
                              style: context.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  if (task.locked)
                    const ILockWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
