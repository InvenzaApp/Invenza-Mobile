import 'dart:async';

import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/di.dart';
import 'package:app/extensions/alert_extension.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/features/user/repository/user_auth_repository.dart';
import 'package:app/screens/app/screens/settings/screens/change_password/cubit/change_password_cubit.dart';
import 'package:app/screens/app/screens/settings/screens/change_password/cubit/change_password_state.dart';
import 'package:app/shared/form_template/i_form_template.dart';
import 'package:app/shared/widgets/i_button.dart';
import 'package:app/shared/widgets/one_ui_scroll_view.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class ChangePasswordPage extends StatelessWidget implements AutoRouteWrapper {
  const ChangePasswordPage({super.key});

  static final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => ChangePasswordCubit(
        repository: inject<UserAuthRepository>(),
      ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      builder: (context, state) {
        return Scaffold(
          body: OneUIScrollView(
            title: l10n.password_page_app_bar_title,
            subtitle: l10n.password_page_app_bar_subtitle,
            slivers: [
              SliverToBoxAdapter(
                child: FormBuilder(
                  key: _formKey,
                  child: Padding(
                    padding: mediumPadding,
                    child: Column(
                      spacing: mediumValue,
                      children: [
                        IFormSecureField(
                          name: 'oldPassword',
                          label: l10n.password_page_old_label,
                          placeholder: l10n.password_page_placeholder,
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                        ),
                        IFormSecureField(
                          name: 'newPassword',
                          label: l10n.password_page_new_label,
                          placeholder: l10n.password_page_placeholder,
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                        ),
                        IFormSecureField(
                          name: 'confirmNewPassword',
                          label: l10n.password_page_confirm_label,
                          placeholder: l10n.password_page_placeholder,
                          validators: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(8),
                                (value) {
                              final password = _formKey.currentState
                                  ?.fields['newPassword']?.value;

                              if (value != password) {
                                return l10n.password_page_passwords_error;
                              }

                              return null;
                            }
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            padding: largePadding,
            decoration: BoxDecoration(
              color: context.container,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IButton(
                  label: l10n.password_page_submit,
                  isPending: state.isLoading,
                  onPressed: () async {
                    if (_formKey.currentState!.saveAndValidate()) {
                      final payload = _formKey.currentState!.value;
                      final userCubit = context.read<UserCubit>();
                      final success = await context
                          .read<ChangePasswordCubit>()
                          .changePassword(payload);

                      if (!success && context.mounted) {
                        await context.showAlert(l10n.password_page_api_error);
                      } else {
                        unawaited(userCubit.signOut());

                        if (context.mounted) {
                          await context.router.replaceAll([const LoginRoute()]);
                        }
                      }
                    }
                  },
                ),
                SizedBox(height: mediumValue),
              ],
            ),
          ),
        );
      },
    );


  }
}
