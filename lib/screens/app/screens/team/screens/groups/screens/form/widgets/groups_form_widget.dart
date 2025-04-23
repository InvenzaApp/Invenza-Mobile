import 'package:app/core/use_case/use_case.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/cubit/user_cubit/user_state.dart';
import 'package:app/di.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/features/group/use_case/groups_update_use_case.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/features/user/network/users_remote_data_source.dart';
import 'package:app/features/user/network/users_repository.dart';
import 'package:app/shared/form_template/i_form_template.dart';
import 'package:app/shared/select_template/widgets/i_form_multiple_select_widget.dart';
import 'package:app/shared/widgets/i_form_skeletonizer.dart';
import 'package:app/shared/widgets/i_scaffold_error_widget.dart';
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
        true => const IFormSkeletonizer(),
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
                    initialValue: resources?.title,
                  ),
                  if (state.organizationResult!.maybeValue!.usersList.length >
                      1)
                    IFormMultipleSelectWidget<User>(
                      name: 'usersIdList',
                      repository: UsersRepository(
                        remoteDS: inject<UsersRemoteDataSource>(),
                      ),
                      label: l10n.groups_create_users_label,
                      title: l10n.groups_create_users_title,
                      subtitle: l10n.groups_create_users_subtitle,
                      dontBuildWithId: state.userResult!.maybeValue!.id,
                      initialIdList: resources?.usersList?.map((e) => e.id).toList(),
                    ),
                ],
              ),
      },
    );
  }
}
