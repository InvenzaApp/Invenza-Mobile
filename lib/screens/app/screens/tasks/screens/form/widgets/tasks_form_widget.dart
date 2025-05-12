import 'dart:async';

import 'package:app/core/use_case/use_case.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/cubit/user_cubit/user_state.dart';
import 'package:app/di.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/features/group/network/groups_remote_data_source.dart';
import 'package:app/features/group/network/groups_repository.dart';
import 'package:app/features/tasks/models/task.dart';
import 'package:app/features/tasks/use_case/tasks_update_use_case.dart';
import 'package:app/screens/app/screens/tasks/screens/form/widgets/task_status/i_form_task_status_widget.dart';
import 'package:app/shared/form_template/i_form_template.dart';
import 'package:app/shared/select_template/widgets/i_form_multiple_select_widget.dart';
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
  bool isError = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (widget.useCase is! UpdateUseCase) return;

    final useCase = widget.useCase as TasksUpdateUseCase;

    final result = await useCase.cockpitRepository.get(useCase.resourceId);

    setState(() {
      resources = result.isSuccess ? result.maybeValue : null;
      isError = result.isError;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final user = context.read<UserCubit>().state.userResult?.maybeValue;

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        return IFormTemplate(
          useCase: widget.useCase,
          onSubmit: (_) => context.maybePop(true),
          fields: (widget.useCase is UpdateUseCase &&
              resources == null)
              ? [const IFormLoadingWidget()]
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
            IFormExpandedTextField(
              name: 'description',
              initialValue: resources?.description,
              label: l10n.task_form_description_label,
              placeholder:
              l10n.task_form_description_placeholder,
            ),
            IFormDateTime(
              name: 'deadline',
              label: l10n.task_form_deadline_label,
              placeholder:
              l10n.task_form_deadline_placeholder,
              initialValue: resources?.deadline,
              valueTransformer: (value) =>
                  value?.toIso8601String(),
            ),
            if (widget.useCase is UpdateUseCase)
              IFormTaskStatusWidget(
                status: resources!.status,
              ),
            IFormMultipleSelectWidget<Group>(
              name: 'groupsIdList',
              label: l10n.task_form_groups_label,
              repository: GroupsRepository(
                remoteDS: inject<GroupsRemoteDataSource>(),
              ),
              initialIdList: resources?.groupsList
                  ?.map((e) => e.id)
                  .toList(),
              validator: FormBuilderValidators.required(),
            ),
            IFormCheckbox(
              name: 'commentsEnabled',
              title: l10n.task_form_comment_title,
              subtitle: l10n.task_form_comment_subtitle,
              initialValue: resources?.commentsEnabled ?? true,
            ),
            if (user?.admin ?? false) ...[
              IFormCheckbox(
                name: 'locked',
                title: l10n.lock_title,
                subtitle: l10n.lock_subtitle,
                initialValue: resources?.locked,
              ),
            ],
          ],
        );
      },
    );
  }
}
