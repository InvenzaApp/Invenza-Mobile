import 'dart:async';

import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_list_tile/i_list_tile.dart';
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
        child: IListTile(
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
              title: l10n.settings_logout_title,
              subtitle: l10n.settings_logout_subtitle,
              icon: Icons.logout,
              onPressed: () async {
                final userCubit = context.read<UserCubit>();
                final success = await context.showConfirm(l10n.logout_confirm);

                if(success != null && success){
                  unawaited(userCubit.signOut());

                  if(context.mounted){
                    await context.replaceRoute(const LoginRoute());
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension ConfirmExtension on BuildContext {
  Future<bool?> showConfirm(String message) async {
    return showDialog<bool>(
      context: this,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.notification),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.confirm),
            ),
          ],
        );
      },
    );
  }
}
