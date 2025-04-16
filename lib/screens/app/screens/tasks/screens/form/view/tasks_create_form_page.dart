import 'package:app/di.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/tasks/network/tasks_remote_data_source.dart';
import 'package:app/features/tasks/network/tasks_repository.dart';
import 'package:app/features/tasks/use_case/tasks_create_use_case.dart';
import 'package:app/screens/app/screens/tasks/screens/form/widgets/tasks_form_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TasksCreateFormPage extends StatelessWidget {
  const TasksCreateFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TasksFormWidget(
      useCase: TasksCreateUseCase(
        cockpitRepository: TasksRepository(
          title: context.l10n.task_form_create_app_bar,
          remoteDS: inject<TasksRemoteDataSource>(),
        ),
      ),
    );
  }
}
