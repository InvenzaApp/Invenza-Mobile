import 'dart:async';

import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/confirm_extension.dart';
import 'package:app/screens/app/screens/settings/widgets/settings_account_widget.dart';
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
        title: l10n.settings_app_bar,
        showBackButton: false,
      ),
      body: Padding(
        padding: largePadding,
        child: Column(
          spacing: largeValue,
          children: [
            const SettingsAccountWidget(),
            IListTile(
              children: [
                IListTileItem(
                  title: l10n.settings_theme_title,
                  subtitle: l10n.settings_theme_subtitle,
                  icon: Icons.dark_mode,
                  onPressed: () => context.pushRoute(const ThemeRoute()),
                ),
                IListTileItem(
                  title: l10n.settings_language_title,
                  subtitle: l10n.settings_language_subtitle,
                  icon: Icons.g_translate,
                  onPressed: () => context.pushRoute(const LanguageRoute()),
                ),
                IListTileItem(
                  title: l10n.settings_password_title,
                  subtitle: l10n.settings_password_subtitle,
                  icon: Icons.password,
                  onPressed: () =>
                      context.pushRoute(const ChangePasswordRoute()),
                ),
                IListTileItem(
                  title: l10n.settings_license_title,
                  subtitle: l10n.settings_license_subtitle,
                  icon: Icons.policy,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const LicensePage(
                        applicationIcon: ILogoWidget(),
                      ),
                    ),
                  ),
                ),
                IListTileItem(
                  title: l10n.settings_logout_title,
                  subtitle: l10n.settings_logout_subtitle,
                  icon: Icons.logout,
                  onPressed: () async {
                    final userCubit = context.read<UserCubit>();
                    final success =
                        await context.showConfirm(l10n.logout_confirm);

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
    );
  }
}
