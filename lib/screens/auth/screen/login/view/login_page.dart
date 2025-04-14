import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/cubit/user_cubit/user_state.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/models/user/user_auth_payload.dart';
import 'package:app/shared/widgets/form/i_secure_field.dart';
import 'package:app/shared/widgets/form/i_text_field.dart';
import 'package:app/shared/widgets/i_button.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
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
                      ),
                      ISecureField(
                        name: 'password',
                        hint: l10n.login_password_label,
                      ),
                      IButton(
                        label: l10n.login_sign_in_button,
                        isPending: state.isLoading,
                        onPressed: () async {
                          if (_formKey.currentState!.saveAndValidate()) {
                            final json = _formKey.currentState!.value;

                            final success = await context
                                .read<UserCubit>()
                                .signIn(UserAuthPayload.fromJson(json));

                            if(success && context.mounted){
                              await context.replaceRoute(const AppRoute());
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
