import 'package:app/core/use_case/use_case.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/di.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/features/group/network/groups_remote_data_source.dart';
import 'package:app/features/group/network/groups_repository.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/features/user/use_case/users_update_use_case.dart';
import 'package:app/shared/form_template/i_form_template.dart';
import 'package:app/shared/select_template/widgets/i_form_multiple_select_widget.dart';
import 'package:app/shared/select_template/widgets/i_form_organization_select_widget.dart';
import 'package:app/shared/select_template/widgets/i_form_permission_select_widget.dart';
import 'package:app/shared/widgets/i_form_skeletonizer.dart';
import 'package:app/shared/widgets/i_scaffold_error_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class UsersFormWidget extends StatefulWidget {
  const UsersFormWidget({required this.useCase, super.key});

  final UseCase useCase;

  @override
  State<UsersFormWidget> createState() => _UsersFormWidgetState();
}

class _UsersFormWidgetState extends State<UsersFormWidget> {
  User? resources;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (widget.useCase is! UpdateUseCase) return;

    final useCase = widget.useCase as UsersUpdateUseCase;

    final result = await useCase.cockpitRepository.get(useCase.resourceId);

    setState(() {
      resources = result.isSuccess ? result.maybeValue! : null;
      isError = result.isError;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final user = context.read<UserCubit>().state.userResult?.maybeValue;

    if (isError) {
      return IScaffoldErrorWidget(
        onPressed: () async => fetchData(),
      );
    }

    if (widget.useCase is UpdateUseCase && resources == null) {
      return const IFormSkeletonizer();
    }

    return IFormTemplate(
      useCase: widget.useCase,
      onSubmit: (_) => context.maybePop(true),
      fields: [
        IFormTextField(
          name: 'name',
          label: l10n.users_create_name_label,
          placeholder: l10n.users_create_name_placeholder,
          validators: [
            FormBuilderValidators.required(),
          ],
          initialValue: resources?.name,
        ),
        IFormTextField(
          name: 'lastname',
          label: l10n.users_create_lastname_label,
          placeholder: l10n.users_create_lastname_placeholder,
          validators: [
            FormBuilderValidators.required(),
          ],
          initialValue: resources?.lastname,
        ),
        IFormTextField(
          name: 'email',
          validators: [
            FormBuilderValidators.required(),
          ],
          label: l10n.users_create_email_label,
          placeholder: l10n.users_create_email_placeholder,
          initialValue: resources?.email,
          keyboardType: TextInputType.emailAddress,
        ),
        if (widget.useCase is CreateUseCase)
          IFormSecureField(
            name: 'password',
            label: l10n.users_create_password_label,
            placeholder: l10n.users_create_password_placeholder,
            validators: [
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(8),
            ],
          ),
        IFormMultipleSelectWidget<Group>(
          name: 'groupsIdList',
          repository: GroupsRepository(
            remoteDS: inject<GroupsRemoteDataSource>(),
          ),
          label: l10n.users_create_groups_label,
          title: l10n.users_create_groups_title,
          subtitle: l10n.users_create_groups_subtitle,
          initialIdList: resources?.groupsIdList,
        ),
        IFormPermissionSelectWidget(
          initialList: resources?.permissions.map((e) => e.name).toList(),
        ),
        if (user?.admin ?? false) ...[
          IFormOrganizationSelectWidget(
            initialList: resources?.organizationsIdList,
          ),
          IFormCheckbox(
            initialValue: resources?.admin,
            name: 'admin',
            title: l10n.users_create_admin_title,
            subtitle: l10n.users_create_admin_subtitle,
          ),
          IFormCheckbox(
            name: 'locked',
            title: l10n.lock_title,
            subtitle: l10n.lock_subtitle,
            initialValue: resources?.locked,
          ),
        ],
      ],
    );
  }
}
