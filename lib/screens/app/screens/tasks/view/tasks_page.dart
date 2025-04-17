import 'package:app/di.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/tasks/network/tasks_remote_data_source.dart';
import 'package:app/features/tasks/network/tasks_repository.dart';
import 'package:app/screens/app/screens/tasks/cubit/tasks_list_cubit.dart';
import 'package:app/screens/app/screens/tasks/screens/list/view/tasks_list_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class TasksPage extends StatelessWidget implements AutoRouteWrapper {
  const TasksPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => TasksListCubit(
        repository: TasksRepository(
          title: context.l10n.tasks_list_app_bar,
          remoteDS: inject<TasksRemoteDataSource>(),
        ),
      ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const TasksListPage();
  }
}
