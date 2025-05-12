import 'package:app/di.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/date_time_extension.dart';
import 'package:app/features/tasks/models/task.dart';
import 'package:app/features/tasks/network/tasks_remote_data_source.dart';
import 'package:app/features/tasks/network/tasks_repository.dart';
import 'package:app/screens/app/screens/tasks/screens/show/cubit/tasks_show_cubit.dart';
import 'package:app/screens/app/screens/tasks/screens/show/widgets/tasks_show_comment_button.dart';
import 'package:app/screens/app/screens/tasks/screens/show/widgets/tasks_show_group_widget.dart';
import 'package:app/shared/show_template/i_show_template.dart';
import 'package:app/shared/widgets/i_alert_widget.dart';
import 'package:app/shared/widgets/i_card/i_card.dart';
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
          padding: mediumPadding,
          child: SingleChildScrollView(
            child: Column(
              spacing: mediumValue,
              children: [
                if (task.groupsList?.isEmpty ?? true)
                  IAlertWidget(
                    message: l10n.task_show_no_group_alert,
                  ),
                ICard(
                  children: [
                    ICardItem(
                      label: l10n.task_show_name,
                      value: task.title,
                    ),
                    if (task.description != null)
                      ICardItem(
                        label: l10n.task_show_description,
                        value: task.description!,
                      ),
                    if (task.deadline != null)
                      ICardItem(
                        label: l10n.task_show_deadline,
                        value: task.deadline!.formattedDateTime(context),
                      ),
                    ICardItem(
                      label: l10n.task_show_created_at,
                      value: task.createdAt.formattedDateTime(context),
                    ),
                    ICardItem(
                      label: l10n.task_show_created_by,
                      value: task.createdBy?.title ??
                          l10n.task_show_created_by_none,
                    ),
                    ICardItem(
                      label: l10n.task_show_status,
                      value: task.status.getName(context),
                    ),
                    if (task.locked) ...[
                      ICardItem(
                        label: l10n.locked,
                        value: l10n.yes,
                      ),
                    ],
                  ],
                ),
                if (task.commentsEnabled)
                  TasksShowCommentButton(
                    task: task,
                  ),
                Column(
                  spacing: smallValue,
                  children: task.groupsList!.map((item) {
                    return TasksShowGroupWidget(group: item);
                  }).toList(),
                ),
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
