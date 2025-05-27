import 'package:app/di.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/features/tasks/models/task.dart';
import 'package:app/features/tasks/network/tasks_remote_data_source.dart';
import 'package:app/features/tasks/network/tasks_repository.dart';
import 'package:app/screens/app/screens/tasks/screens/list/widgets/task_status_widget.dart';
import 'package:app/screens/app/screens/tasks/screens/show/cubit/tasks_show_cubit.dart';
import 'package:app/screens/app/screens/tasks/screens/show/widgets/tasks_show_comment_button.dart';
import 'package:app/screens/app/screens/tasks/screens/show/widgets/tasks_show_group_widget.dart';
import 'package:app/shared/show_template/i_show_template.dart';
import 'package:app/shared/widgets/i_alert_widget.dart';
import 'package:app/shared/widgets/i_lock_widget.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TasksShowPage extends StatelessWidget {
  const TasksShowPage({
    @pathParam required this.resourceId,
    super.key,
  });

  final int resourceId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return IShowTemplate<Task>(
      cubit: TasksShowCubit(
        resourceId: resourceId,
        repository: TasksRepository(
          remoteDS: inject<TasksRemoteDataSource>(),
          title: l10n.task_show_app_bar,
        ),
      ),
      builder: (context, cubit) {
        final task = cubit.data;

        return Padding(
          padding: xxLargePadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (task.groupsList?.isEmpty ?? true) ...[
                  IAlertWidget(
                    message: l10n.task_show_no_group_alert,
                  ),
                  SizedBox(height: largeValue),
                ],
                TaskStatusWidget(task: task),
                SizedBox(height: mediumValue),
                IShowTitleWidget(
                  text: task.title,
                ),
                SizedBox(height: largeValue),
                IShowCreatedAtWidget(dateTime: task.createdAt),
                if (task.deadline != null) ...[
                  SizedBox(height: mediumValue),
                  IShowDeadlineWidget(
                    deadline: task.deadline!,
                  ),
                ],
                SizedBox(height: smallValue),
                IShowAuthorWidget(
                  user: task.createdBy!,
                ),
                if(task.locked)...[
                  const ILockWidget(),
                ],
                SizedBox(height: largeValue),
                if(task.description != null) ...[
                  IShowDescriptionWidget(
                    text: task.description!,
                  ),
                  SizedBox(height: largeValue),
                ],
                if(task.commentsEnabled)...[
                  TasksShowCommentButton(task: task),
                  SizedBox(height: largeValue),
                ],
                if(task.groupsList!.isNotEmpty)...[
                  Text(
                    context.l10n.task_form_groups_label,
                    style: context.bodyMedium,
                  ),
                  SizedBox(height: smallValue),
                  Column(
                    spacing: smallValue,
                    children: task.groupsList!.map((item) {
                      return TasksShowGroupWidget(group: item);
                    }).toList(),
                  ),
                  SizedBox(height: largeValue),
                ],
              ],
            ),
          ),
        );
      },
      updatePermission: Permissions.update_task,
      deletePermission: Permissions.delete_task,
    );
  }
}
