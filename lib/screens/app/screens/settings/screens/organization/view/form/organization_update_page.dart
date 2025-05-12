import 'dart:async';

import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/di.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/toast_extension.dart';
import 'package:app/features/organization/network/organization_repository.dart';
import 'package:app/screens/app/screens/settings/screens/organization/cubit/organization_cubit.dart';
import 'package:app/screens/app/screens/settings/screens/organization/cubit/organization_state.dart';
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
class OrganizationUpdatePage extends StatelessWidget
    implements AutoRouteWrapper {
  const OrganizationUpdatePage({super.key});

  static final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => OrganizationCubit(
        repository: inject<OrganizationRepository>(),
      ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();

    return BlocBuilder<OrganizationCubit, OrganizationState>(
      builder: (context, state) {
        final l10n = context.l10n;
        final organization = userCubit.state.organizationResult?.maybeValue;

        return Scaffold(
          appBar: iAppBar(
            context: context,
            title: l10n.organization_update_app_bar,
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
                            name: 'title',
                            label: l10n.organization_update_title_label,
                            placeholder:
                                l10n.organization_update_title_placeholder,
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                            initialValue: organization?.title,
                          ),
                          IFormTextField(
                            name: 'street',
                            label: l10n.organization_update_street_title,
                            placeholder:
                                l10n.organization_update_street_placeholder,
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                            initialValue: organization?.address.street,
                          ),
                          IFormTextField(
                            name: 'buildingNumber',
                            label: l10n.organization_update_building_title,
                            placeholder:
                                l10n.organization_update_building_placeholder,
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                            initialValue: organization?.address.buildingNumber,
                          ),
                          IFormTextField(
                            name: 'apartmentNumber',
                            label: l10n.organization_update_apartment_title,
                            placeholder:
                                l10n.organization_update_apartment_placeholder,
                            initialValue: organization?.address.apartmentNumber,
                          ),
                          IFormTextField(
                            name: 'postCode',
                            label: l10n.organization_update_post_code_title,
                            placeholder:
                                l10n.organization_update_post_code_placeholder,
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                            initialValue: organization?.address.postCode,
                          ),
                          IFormTextField(
                            name: 'city',
                            label: l10n.organization_update_city_title,
                            placeholder:
                                l10n.organization_update_city_placeholder,
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                            initialValue: organization?.address.city,
                          ),
                          IFormTextField(
                            name: 'country',
                            label: l10n.organization_update_country_title,
                            placeholder:
                                l10n.organization_update_country_placeholder,
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                            initialValue: organization?.address.country,
                          ),
                          if (userCubit.state.userResult?.maybeValue?.admin ??
                              false) ...[
                            IFormCheckbox(
                              name: 'locked',
                              title: l10n.lock_title,
                              subtitle: l10n.lock_subtitle,
                              initialValue: organization?.locked,
                            ),
                          ],
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
                        isPending: state.isLoading,
                        label: l10n.update,
                        onPressed: () async {
                          if (_formKey.currentState!.saveAndValidate()) {
                            final payload = _formKey.currentState!.value;
                            final cubit = context.read<OrganizationCubit>();

                            final success =
                                await cubit.updateOrganization(payload);

                            if (success && context.mounted) {
                              unawaited(userCubit.fetchOrganization());
                              await context.maybePop();
                            } else {
                              if (!context.mounted) return;
                              context.showToast(
                                l10n.organization_update_unknown_error,
                              );
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
