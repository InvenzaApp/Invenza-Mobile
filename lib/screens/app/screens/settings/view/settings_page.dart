import 'dart:async';

import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/core/user_permissions/user_permissions.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/confirm_extension.dart';
import 'package:app/screens/app/screens/settings/widgets/settings_account_widget.dart';
import 'package:app/screens/app/screens/settings/widgets/settings_organization_widget.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_list_tile/i_list_tile.dart';
import 'package:app/shared/widgets/i_logo_widget.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: iAppBar(
        context: context,
        title: l10n.settings_app_bar_title,
        showBackButton: false,
      ),
      body: Padding(
        padding: mediumPadding,
        child: SingleChildScrollView(
          child: Column(
            spacing: mediumValue,
            children: [
              const SettingsAccountWidget(),
              const SettingsOrganizationWidget(),
              IListTileWidget(
                children: [
                  if (UserPermissions.hasPermission(
                    Permissions.other_account_show,
                  )) ...[
                    IListTile(
                      title: l10n.settings_account_title,
                      icon: Icons.person,
                      onPressed: () => context.pushRoute(const AccountRoute()),
                    ),
                  ],
                  if (UserPermissions.hasPermission(
                    Permissions.show_organization,
                  )) ...[
                    IListTile(
                      title: l10n.settings_organization_title,
                      icon: Icons.business,
                      onPressed: () =>
                          context.pushRoute(const OrganizationShowRoute()),
                    ),
                  ],
                  IListTile(
                    title: l10n.settings_theme_title,
                    icon: Icons.dark_mode,
                    onPressed: () => context.pushRoute(const ThemeRoute()),
                  ),
                  IListTile(
                    title: l10n.settings_language_title,
                    icon: Icons.g_translate,
                    onPressed: () => context.pushRoute(const LanguageRoute()),
                  ),
                  IListTile(
                    title: l10n.settings_password_title,
                    icon: Icons.password,
                    onPressed: () => context.pushRoute(const ChangePasswordRoute()),
                  ),
                  IListTile(
                    title: l10n.settings_license_title,
                    icon: Icons.policy,
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => const LicensePage(
                          applicationIcon: ILogoWidget(),
                        ),
                      ),
                    ),
                  ),
                  IListTile(
                    title: l10n.settings_logout_title,
                    icon: Icons.logout,
                    onPressed: () async {
                      final userCubit = context.read<UserCubit>();
                      final success = await context.showConfirm(l10n.logout_confirm);
              
                      if (success != null && success) {
                        unawaited(userCubit.signOut());
              
                        if (context.mounted) {
                          await context.replaceRoute(const LoginRoute());
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
