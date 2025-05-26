import 'package:app/di.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/organization/network/organization_repository.dart';
import 'package:app/features/organization/use_case/organization_create_use_case.dart';
import 'package:app/shared/form_template/widgets/i_form_template.dart';
import 'package:app/shared/form_template/widgets/i_form_text_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class OrganizationCreatePage extends StatelessWidget {
  const OrganizationCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return IFormTemplate(
      useCase: OrganizationCreateUseCase(
        cockpitRepository: inject<OrganizationRepository>(),
      ),
      onSubmit: (_) => context.maybePop(true),
      appbarTitle: l10n.organization_create_app_bar,
      fields: [
        IFormTextField(
          name: 'title',
          validators: [
            FormBuilderValidators.required(),
          ],
          label: l10n.organization_create_title_label,
          placeholder: l10n.organization_create_title_placeholder,
        ),
        IFormTextField(
          name: 'street',
          validators: [
            FormBuilderValidators.required(),
          ],
          label: l10n.organization_create_street_label,
          placeholder: l10n.organization_create_street_placeholder,
        ),
        IFormTextField(
          name: 'buildingNumber',
          validators: [
            FormBuilderValidators.required(),
          ],
          label: l10n.organization_create_building_label,
          placeholder: l10n.organization_create_building_placeholder,
        ),
        IFormTextField(
          name: 'apartmentNumber',
          label: l10n.organization_create_apartment_label,
          placeholder: l10n.organization_create_apartment_placeholder,
        ),
        IFormTextField(
          name: 'postCode',
          validators: [
            FormBuilderValidators.required(),
          ],
          label: l10n.organization_create_post_code_label,
          placeholder: l10n.organization_create_post_code_placeholder,
        ),
        IFormTextField(
          name: 'city',
          validators: [
            FormBuilderValidators.required(),
          ],
          label: l10n.organization_create_city_label,
          placeholder: l10n.organization_create_city_placeholder,
        ),
        IFormTextField(
          name: 'country',
          validators: [
            FormBuilderValidators.required(),
          ],
          label: l10n.organization_create_country_label,
          placeholder: l10n.organization_create_country_placeholder,
        ),
      ],
    );
  }
}
