import 'package:app/core/use_case/use_case.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/cubit/user_cubit/user_state.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/features/group/use_case/groups_update_use_case.dart';
import 'package:app/shared/form_template/i_form_template.dart';
import 'package:app/shared/widgets/i_scaffold_error_widget.dart';
import 'package:app/shared/widgets/i_scaffold_loading_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class GroupsFormWidget extends StatefulWidget {
  const GroupsFormWidget({required this.useCase, super.key});

  final UseCase useCase;

  @override
  State<GroupsFormWidget> createState() => _GroupsFormWidgetState();
}

class _GroupsFormWidgetState extends State<GroupsFormWidget> {
  Group? resources;

  @override
  void initState() {
    super.initState();
    fetchData();
    context.read<UserCubit>().fetchOrganization();
  }

  Future<void> fetchData() async {
    if (widget.useCase is! UpdateUseCase) return;

    final useCase = widget.useCase as GroupsUpdateUseCase;

    final result = await useCase.cockpitRepository.get(useCase.resourceId);

    if (result.isSuccess) {
      setState(() {
        resources = result.maybeValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) => switch (state.isLoading) {
        true => const IScaffoldLoadingWidget(),
        false => (state.organizationResult?.isError ?? true)
            ? IScaffoldErrorWidget(
                onPressed: () async {
                  await context.read<UserCubit>().signInWithSavedCredentials();
                },
              )
            : IFormTemplate(
                useCase: widget.useCase,
                onSubmit: (_) => context.maybePop(true),
                fields: [
                  IFormTextField(
                    name: 'name',
                    label: l10n.groups_create_name_label,
                    placeholder: l10n.groups_create_name_placeholder,
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    initialValue: resources?.name,
                  ),
                  if (state.organizationResult!.maybeValue!.usersList.length >
                      1)
                    IFormCheckboxGroup<int>(
                      name: 'usersIdList',
                      label: context.l10n.groups_create_users_label,
                      options: state.organizationResult!.maybeValue!.usersList
                          .where(
                        (item) => item != state.userResult!.maybeValue!,
                      )
                          .map((user) {
                        return IFormOption(
                          label: '${user.name} ${user.lastname}',
                          value: user.id,
                        );
                      }).toList(),
                      initialValue: (resources?.usersList ?? [])
                          .map((e) => e.id)
                          .toList(),
                    ),
                ],
              ),
      },
    );
  }
}
