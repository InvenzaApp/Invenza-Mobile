import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/screens/app/screens/tasks/cubit/tasks_list_cubit.dart';
import 'package:app/screens/app/screens/tasks/cubit/tasks_list_state.dart';
import 'package:app/screens/app/screens/tasks/screens/list/widgets/tasks_list_widget.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_error_widget.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class TasksListPage extends StatelessWidget {
  const TasksListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: iAppBar(
        context: context,
        title: context.l10n.tasks_list_app_bar,
        showBackButton: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final cubit = context.read<TasksListCubit>();
          final needUpdate =
              await context.pushRoute(const TasksCreateFormRoute());

          if (needUpdate == true) {
            await cubit.fetch();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TasksListCubit, TasksListState>(
        builder: (context, state) {
          if (state.result?.isError ?? true) {
            return const IErrorWidget();
          }

          return Padding(
            padding: mediumPadding,
            child: state.result!.maybeValue!.isEmpty
                ? IErrorWidget(
                    icon: Icons.no_sim_outlined,
                    title: context.l10n.tasks_list_no_tasks_title,
                    showSubtitle: false,
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      await context.read<TasksListCubit>().fetch();
                    },
                    child: ListView.builder(
                      itemCount: state.result!.maybeValue!.length,
                      itemBuilder: (context, index) {
                        final item = state.result!.maybeValue![index];

                        return Column(
                          children: [
                            TasksListWidget(task: item),
                            SizedBox(
                              height: mediumValue,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
          );
        },
      ),
    );
  }
}
