import 'package:app/core/use_case/use_case.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/cubit/user_cubit/user_state.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/shared/form_template/i_form_widget.dart';
import 'package:app/shared/widgets/form/i_form_checkbox_group.dart';
import 'package:app/shared/widgets/form/i_form_text_field.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().fetchOrganization();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state.organizationResult?.isSuccess ?? false) {
          final organization = state.organizationResult!.maybeValue!;
          final user = state.userResult!.maybeValue!;

          return IFormWidget(
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
              ),
              IFormCheckboxGroup<int>(
                name: 'usersIdList',
                label: context.l10n.groups_create_users_label,
                options: organization.usersList
                    .where((item) => item != user)
                    .map((user) {
                  return IFormOption(
                    label: '${user.name} ${user.lastname}',
                    value: user.id,
                  );
                }).toList(),
                initialValue: [user.id],
              ),
            ],
          );
        } else {
          return IScaffoldErrorWidget(
            onPressed: () async {
              await context.read<UserCubit>().signInWithSavedCredentials();
            },
          );
        }
      },
    );
  }
}
