import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_list_tile/i_list_tile.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }
}
