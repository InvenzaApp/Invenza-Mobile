import 'dart:async';

import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/di.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/confirm_extension.dart';
import 'package:app/features/tasks/network/tasks_remote_data_source.dart';
import 'package:app/features/tasks/network/tasks_repository.dart';
import 'package:app/screens/app/screens/tasks/screens/list/widgets/tasks_list_widget.dart';
import 'package:app/screens/app/screens/tasks/screens/show/cubit/tasks_show_cubit.dart';
import 'package:app/screens/app/screens/tasks/screens/show/cubit/tasks_show_state.dart';
import 'package:app/screens/app/screens/tasks/screens/show/widgets/tasks_show_group_widget.dart';
import 'package:app/shared/widgets/i_alert_widget.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_card/i_card.dart';
import 'package:app/shared/widgets/i_error_widget.dart';
import 'package:app/shared/widgets/i_loading_widget.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class TasksShowPage extends StatefulWidget implements AutoRouteWrapper {
  const TasksShowPage({
    @pathParam required this.resourceId,
    super.key,
  });

  final int resourceId;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => TasksShowCubit(
        repository: TasksRepository(
          remoteDS: inject<TasksRemoteDataSource>(),
        ),
        resourceId: resourceId,
      ),
      child: this,
    );
  }

  @override
  State<TasksShowPage> createState() => _TasksShowPageState();
}

class _TasksShowPageState extends State<TasksShowPage> {
  bool requireUpdate = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: iAppBar(
        backButtonAction: () {
          context.maybePop(requireUpdate);
        },
        context: context,
        title: l10n.task_show_app_bar,
        actions: [
          IconButton(
            onPressed: () async {
              final cubit = context.read<TasksShowCubit>();
              final success =
                  await context.showConfirm(l10n.task_show_delete_confirm);

              if (success != null && success) {
                unawaited(cubit.delete());

                if (context.mounted) {
                  await context.maybePop(true);
                }
              }
            },
            icon: Icon(
              Icons.delete,
              color: context.error,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final cubit = context.read<TasksShowCubit>();
          final needUpdate = await context.pushRoute(
            TasksUpdateFormRoute(
              resourceId: widget.resourceId,
            ),
          );

          if (needUpdate == true && context.mounted) {
            setState(() {
              requireUpdate = true;
            });
            await cubit.fetch();
          }
        },
        child: const Icon(Icons.edit),
      ),
      body: BlocBuilder<TasksShowCubit, TasksShowState>(
        builder: (context, state) => switch (state.isLoading) {
          true => const ILoadingWidget(),
          false => (state.result?.isError ?? true)
              ? const IErrorWidget()
              : Padding(
                  padding: largePadding,
                  child: Column(
                    spacing: mediumValue,
                    children: [
                      if (state.result!.maybeValue!.groupsList?.isEmpty ?? true)
                        IAlertWidget(message: l10n.task_show_no_group_alert),
                      ICard(
                        children: [
                          ICardItem(
                            label: l10n.task_show_name,
                            value: state.result!.maybeValue!.title,
                          ),
                          if (state.result!.maybeValue!.description
                                  ?.isNotEmpty ??
                              false)
                            ICardItem(
                              label: l10n.task_show_description,
                              value: state.result!.maybeValue!.description!,
                            ),
                          if (state.result!.maybeValue!.deadline != null)
                            ICardItem(
                              label: l10n.task_show_deadline,
                              value: state.result!.maybeValue!.deadline!
                                  .formattedDateTime,
                            ),
                          ICardItem(
                            label: l10n.task_show_created_at,
                            value: state.result!.maybeValue!.createdAt
                                .formattedDateTime,
                          ),
                          ICardItem(
                            label: l10n.task_show_created_by,
                            value: '${state.result!.maybeValue!.createdBy.name} '
                                '${state.result!.maybeValue!.createdBy.lastname}',
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              state.result!.maybeValue!.groupsList!.length,
                          itemBuilder: (context, index) {
                            final group =
                                state.result!.maybeValue!.groupsList![index];

                            return Column(
                              children: [
                                TasksShowGroupWidget(
                                  group: group,
                                ),
                                SizedBox(height: smallValue),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        },
      ),
    );
  }
}
