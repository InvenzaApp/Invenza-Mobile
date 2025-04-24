import 'package:app/core/use_case/use_case.dart';
import 'package:app/di.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/features/group/network/groups_remote_data_source.dart';
import 'package:app/features/group/network/groups_repository.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/features/user/use_case/users_update_use_case.dart';
import 'package:app/shared/form_template/i_form_template.dart';
import 'package:app/shared/select_template/widgets/i_form_multiple_select_widget.dart';
import 'package:app/shared/select_template/widgets/i_form_permission_select_widget.dart';
import 'package:app/shared/widgets/i_form_skeletonizer.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class UsersFormWidget extends StatefulWidget {
  const UsersFormWidget({required this.useCase, super.key});

  final UseCase useCase;

  @override
  State<UsersFormWidget> createState() => _UsersFormWidgetState();
}

class _UsersFormWidgetState extends State<UsersFormWidget> {
  User? resources;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (widget.useCase is! UpdateUseCase) return;

    final useCase = widget.useCase as UsersUpdateUseCase;

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

    if(widget.useCase is UpdateUseCase && resources == null){
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
      ],
    );
  }
}
