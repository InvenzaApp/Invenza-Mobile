import 'dart:async';

import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/cubit/user_cubit/user_state.dart';
import 'package:app/enums/api_messages.dart';
import 'package:app/extensions/alert_extension.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/user/models/user_auth_payload.dart';
import 'package:app/screens/auth/screen/login/widgets/login_language_selector_widget.dart';
import 'package:app/shared/form_template/widgets/i_form_secure_field.dart';
import 'package:app/shared/form_template/widgets/i_form_text_field.dart';
import 'package:app/shared/widgets/i_button.dart';
import 'package:app/shared/widgets/i_logo_widget.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static final _formKey = GlobalKey<FormBuilderState>();
  static bool _hasNavigated = false;
  static bool _shownAlert = false;

  Future<void> _signIn(UserCubit cubit) async {
    if (_formKey.currentState!.saveAndValidate()) {
      final json = _formKey.currentState!.value;
      _hasNavigated = false;
      await cubit.signIn(UserAuthPayload.fromJson(json));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<UserCubit, UserState>(
      listener: (context, state) async {
        if (!state.isLoading && (state.userResult?.isError ?? true)) {
          final cubit = context.read<UserCubit>();
          final error = cubit.state.userResult?.maybeError;
          cubit.reset();
          if (!_shownAlert) {
            _shownAlert = true;
            await context.showAlert(
              (error ?? ApiMessages.unknownError).asString(context),
            );
            _shownAlert = false;
          }
        } else if ((state.userResult?.isSuccess ?? false) && !_hasNavigated) {
          _hasNavigated = true;
          await context.replaceRoute(const OrganizationsListRoute());
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: largePadding,
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      spacing: smallValue,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const ILogoWidget(),
                        IFormTextField(
                          name: 'email',
                          placeholder: l10n.login_email_placeholder,
                          label: l10n.login_email_label,
                          validators: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ],
                          keyboardType: TextInputType.emailAddress,
                        ),
                        IFormSecureField(
                          name: 'password',
                          placeholder: l10n.login_password_placeholder,
                          label: l10n.login_password_label,
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                        ),
                        IButton(
                          label: l10n.login_sign_in_button,
                          isPending: state.isLoading,
                          onPressed: () async =>
                              _signIn(context.read<UserCubit>()),
                        ),
                        const LoginLanguageSelectorWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
