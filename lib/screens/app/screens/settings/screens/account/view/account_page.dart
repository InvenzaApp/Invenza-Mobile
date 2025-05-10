import 'dart:async';

import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/core/user_permissions/user_permissions.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/di.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/alert_extension.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/features/user/repository/user_update_repository.dart';
import 'package:app/screens/app/screens/settings/screens/account/cubit/account_cubit.dart';
import 'package:app/screens/app/screens/settings/screens/account/cubit/account_state.dart';
import 'package:app/shared/form_template/i_form_template.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_button.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class AccountPage extends StatefulWidget implements AutoRouteWrapper {
  const AccountPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountCubit(
        repository: inject<UserUpdateRepository>(),
      ),
      child: this,
    );
  }

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late User user;
  static final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    user = context.read<UserCubit>().state.userResult!.maybeValue!;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        return Scaffold(
          appBar: iAppBar(
            context: context,
            title: l10n.account_app_bar,
          ),
          body: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: mediumPadding,
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: mediumValue,
                        children: [
                          IFormTextField(
                            name: 'name',
                            label: l10n.account_name_title,
                            placeholder: l10n.account_name_placeholder,
                            initialValue: user.name,
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                            disabled: !UserPermissions.hasPermission(
                              Permissions.other_account_update,
                            ),
                          ),
                          IFormTextField(
                            name: 'lastname',
                            label: l10n.account_lastname_title,
                            placeholder: l10n.account_lastname_placeholder,
                            initialValue: user.lastname,
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                            disabled: !UserPermissions.hasPermission(
                              Permissions.other_account_update,
                            ),
                          ),
                          IFormTextField(
                            name: 'email',
                            label: l10n.account_email_title,
                            placeholder: l10n.account_email_placeholder,
                            initialValue: user.email,
                            keyboardType: TextInputType.emailAddress,
                            validators: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                            ],
                            disabled: !UserPermissions.hasPermission(
                              Permissions.other_account_update,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: largePadding,
                  decoration: BoxDecoration(
                    color: context.container,
                  ),
                  child: Column(
                    children: [
                      IButton(
                        enabled: UserPermissions.hasPermission(
                          Permissions.other_account_update,
                        ),
                        isPending: state.isLoading,
                        label: l10n.update,
                        onPressed: () async {
                          if (_formKey.currentState!.saveAndValidate()) {
                            final cubit = context.read<AccountCubit>();
                            final userCubit = context.read<UserCubit>();

                            final payload = _formKey.currentState!.value;
                            final success = await cubit.updateUser(payload);

                            if (success) {
                              unawaited(userCubit.signOut());

                              if (context.mounted) {
                                await context.router.replaceAll(
                                  [const LoginRoute()],
                                );
                              }
                            } else {
                              if (!context.mounted) return;
                              await context
                                  .showAlert(l10n.account_email_taken_alert);
                            }
                          }
                        },
                      ),
                      SizedBox(height: mediumValue),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
