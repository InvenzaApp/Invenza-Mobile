import 'package:app/di.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/tasks/models/task.dart';
import 'package:app/features/tasks/network/tasks_remote_data_source.dart';
import 'package:app/features/tasks/network/tasks_repository.dart';
import 'package:app/screens/app/screens/tasks/screens/list/cubits/tasks_list_cubit.dart';
import 'package:app/screens/app/screens/tasks/screens/list/widgets/tasks_list_widget.dart';
import 'package:app/shared/list_template/i_list_template.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TasksListPage extends StatelessWidget {
  const TasksListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IListTemplate<Task>(
      cubit: TasksListCubit(
        repository: TasksRepository(
          remoteDS: inject<TasksRemoteDataSource>(),
          title: context.l10n.tasks_list_app_bar,
        ),
      ),
      createPermission: Permissions.add_task,
      listPermission: Permissions.list_task,
      widget: (context, item) {
        return TasksListWidget(task: item);
      },
    );
  }
}
