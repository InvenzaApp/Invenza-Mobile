import 'dart:async';

import 'package:app/core/use_case/use_case.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/cubit/user_cubit/user_state.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/tasks/models/task.dart';
import 'package:app/features/tasks/use_case/tasks_update_use_case.dart';
import 'package:app/screens/app/screens/team/screens/groups/screens/list/cubit/groups_list_cubit.dart';
import 'package:app/screens/app/screens/team/screens/groups/screens/list/cubit/groups_list_state.dart';
import 'package:app/shared/form_template/i_form_widget.dart';
import 'package:app/shared/widgets/form/i_form_checkbox_group.dart';
import 'package:app/shared/widgets/form/i_form_date_time.dart';
import 'package:app/shared/widgets/form/i_form_text_field.dart';
import 'package:app/shared/widgets/i_loading_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class TasksFormWidget extends StatefulWidget {
  const TasksFormWidget({
    required this.useCase,
    super.key,
  });

  final UseCase useCase;

  @override
  State<TasksFormWidget> createState() => _TasksFormWidgetState();
}

class _TasksFormWidgetState extends State<TasksFormWidget> {
  Task? resources;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (widget.useCase is! UpdateUseCase) return;

    final useCase = widget.useCase as TasksUpdateUseCase;

    final task = await useCase.cockpitRepository.get(useCase.resourceId);

    setState(() {
      resources = task;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<GroupsListCubit, GroupsListState>(
      builder: (context, groupsState) {
        return BlocBuilder<UserCubit, UserState>(
          builder: (context, userState) {
            return IFormWidget(
              useCase: widget.useCase,
              onSubmit: (_) => context.maybePop(true),
              fields: (widget.useCase is UpdateUseCase && resources == null)
                  ? [const ILoadingWidget()]
                  : [
                      IFormTextField(
                        name: 'title',
                        label: l10n.task_form_name_label,
                        placeholder: l10n.task_form_name_placeholder,
                        initialValue: resources?.title,
                        validators: [
                          FormBuilderValidators.required(),
                        ],
                      ),
                      IFormTextField(
                        name: 'description',
                        initialValue: resources?.description,
                        label: l10n.task_form_description_label,
                        placeholder: l10n.task_form_description_placeholder,
                      ),
                      IFormDateTime(
                        name: 'deadline',
                        label: l10n.task_form_deadline_label,
                        placeholder: l10n.task_form_deadline_placeholder,
                        initialValue: resources?.deadline,
                        valueTransformer: (value) => value?.toIso8601String(),
                      ),
                      IFormCheckboxGroup(
                        name: 'groupsIdList',
                        label: l10n.task_form_groups_label,
                        initialValue: resources?.groupsIdList,
                        options: groupsState.groupsList
                            .map(
                              (group) => IFormOption(
                                label: group.name,
                                value: group.id,
                              ),
                            )
                            .toList(),
                        validators: [
                          FormBuilderValidators.required(),
                        ],
                      ),
                    ],
            );
          },
        );
      },
    );
  }
}
