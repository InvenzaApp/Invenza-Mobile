import 'package:app/di.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/tasks/network/tasks_remote_data_source.dart';
import 'package:app/features/tasks/network/tasks_repository.dart';
import 'package:app/features/tasks/use_case/tasks_update_use_case.dart';
import 'package:app/screens/app/screens/tasks/screens/form/widgets/tasks_form_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TasksUpdateFormPage extends StatelessWidget {
  const TasksUpdateFormPage({
    required this.resourceId,
    super.key,
  });

  final int resourceId;

  @override
  Widget build(BuildContext context) {
    final repository = TasksRepository(
      remoteDS: inject<TasksRemoteDataSource>(),
      title: context.l10n.task_form_update_app_bar,
    );

    return TasksFormWidget(
      useCase: TasksUpdateUseCase(
        resourceId: resourceId,
        cockpitRepository: repository,
      ),
    );
  }
}
