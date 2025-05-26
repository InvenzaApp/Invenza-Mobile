import 'dart:async';

import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/cubit/user_cubit/user_state.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/confirm_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/shared/widgets/i_loading_widget.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class OrganizationsListPage extends StatefulWidget {
  const OrganizationsListPage({super.key});

  @override
  State<OrganizationsListPage> createState() => _OrganizationsListPageState();
}

class _OrganizationsListPageState extends State<OrganizationsListPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().fetchOrganizations();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state.userResult!.maybeValue!;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.organization_app_bar),
        centerTitle: false,
        actions: [
          if (user.superadmin) ...[
            IconButton(
              onPressed: () async {
                final userCubit = context.read<UserCubit>();
                final requireUpdate =
                    await context.pushRoute(const OrganizationCreateRoute());

                if (requireUpdate == true) {
                  await userCubit.fetchOrganizations();
                }
              },
              icon: const Icon(Icons.add_business_outlined),
            ),
          ],
          IconButton(
            onPressed: () async {
              final userCubit = context.read<UserCubit>();
              final success =
                  await context.showConfirm(context.l10n.logout_confirm);

              if (success != null && success) {
                unawaited(userCubit.signOut());

                if (context.mounted) {
                  await context.replaceRoute(const LoginRoute());
                }
              }
            },
            icon: Icon(
              Icons.power_settings_new,
              color: context.error,
            ),
          ),
        ],
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state.isFetchingOrganizations) {
            return const ILoadingWidget();
          }

          return RefreshIndicator(
            onRefresh: () async {
              await context.read<UserCubit>().fetchOrganizations();
            },
            child: ListView.builder(
              itemCount: state.organizationsList.length,
              itemBuilder: (context, index) {
                final organization = state.organizationsList[index];

                return InkWell(
                  onTap: () async {
                    await context
                        .read<UserCubit>()
                        .selectOrganization(organization.id);

                    if(!context.mounted) return;

                    await context.router.replaceAll([const AppRoute()]);
                  },
                  child: Ink(
                    padding: largePadding,
                    child: Row(
                      spacing: mediumValue,
                      children: [
                        Container(
                          padding: mediumPadding,
                          decoration: BoxDecoration(
                            color: context.primary,
                            borderRadius: smallRadius,
                          ),
                          child: Icon(
                            Icons.business,
                            color: context.onPrimary,
                          ),
                        ),
                        Text(
                          organization.title,
                          style: context.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
