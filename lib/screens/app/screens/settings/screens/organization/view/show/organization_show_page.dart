import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/core/user_permissions/user_permissions.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/cubit/user_cubit/user_state.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/organization/models/organization.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_card/i_card.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class OrganizationShowPage extends StatelessWidget {
  const OrganizationShowPage({super.key});

  bool canEdit(UserState userState, Organization? organization) {
    if (!UserPermissions.hasPermission(Permissions.update_organization)) {
      return false;
    }

    if (userState.userResult?.maybeValue?.admin ?? false) return true;

    if(organization?.locked ?? true) return false;

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final l10n = context.l10n;
        final organization = state.organizationResult?.maybeValue;

        return Scaffold(
          appBar: iAppBar(
            context: context,
            title: l10n.organization_app_bar,
          ),
          floatingActionButton: canEdit(
            context.read<UserCubit>().state,
            organization,
          )
              ? FloatingActionButton(
                  child: const Icon(Icons.edit),
                  onPressed: () =>
                      context.pushRoute(const OrganizationUpdateRoute()),
                )
              : null,
          body: Column(
            children: [
              Padding(
                padding: mediumPadding,
                child: ICard(
                  children: [
                    ICardItem(
                      label: l10n.organization_title,
                      value: organization?.title ?? '',
                    ),
                    ICardItem(
                      label: l10n.address_street,
                      value: '${organization?.address.street} '
                          '${organization?.address.buildingNumber}',
                    ),
                    if (organization?.address.apartmentNumber != null &&
                        organization?.address.apartmentNumber != '')
                      ICardItem(
                        label: l10n.address_apartment_number,
                        value: organization?.address.apartmentNumber! ?? '',
                      ),
                    ICardItem(
                      label: l10n.address_city,
                      value: organization?.address.city ?? '',
                    ),
                    ICardItem(
                      label: l10n.address_post_code,
                      value: organization?.address.postCode ?? '',
                    ),
                    ICardItem(
                      label: l10n.address_country,
                      value: organization?.address.country ?? '',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
