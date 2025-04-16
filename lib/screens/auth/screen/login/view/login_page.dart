import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/cubit/user_cubit/user_state.dart';
import 'package:app/extensions/alert_extension.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/user/models/user_auth_payload.dart';
import 'package:app/screens/auth/screen/login/widgets/login_language_selector_widget.dart';
import 'package:app/shared/widgets/form/i_secure_field.dart';
import 'package:app/shared/widgets/form/i_text_field.dart';
import 'package:app/shared/widgets/i_button.dart';
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

  Future<void> _signIn(UserCubit cubit) async {
    if (_formKey.currentState!.saveAndValidate()) {
      final json = _formKey.currentState!.value;

      await cubit.signIn(UserAuthPayload.fromJson(json));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<UserCubit, UserState>(
      listener: (context, state) async {
        if (state.user.isError) {
          final cubit = context.read<UserCubit>();
          await context.showAlert(
            state.user.maybeError!.errorMessage.asString(
              context,
            ),
          );
          cubit.reset();
        } else if (state.user.isSuccess) {
          await context.replaceRoute(const AppRoute());
        }
      },
      child: Scaffold(
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
                        ITextField(
                          name: 'email',
                          hint: l10n.login_email_label,
                          validators: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ],
                        ),
                        ISecureField(
                          name: 'password',
                          hint: l10n.login_password_label,
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
