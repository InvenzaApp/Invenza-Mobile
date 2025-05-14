import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/core/user_permissions/user_permissions.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_list_tile/i_list_tile.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: iAppBar(
        context: context,
        title: l10n.team_app_bar,
        showBackButton: false,
      ),
      body: Padding(
        padding: largePadding,
        child: IListTile(
          children: [
            IListTileItem(
              title: l10n.team_users_title,
              icon: Icons.person,
              onPressed: () => context.pushRoute(const UsersListRoute()),
            ),
            IListTileItem(
              title: l10n.team_groups_title,
              icon: Icons.groups,
              onPressed: () => context.pushRoute(const GroupsListRoute()),
            ),
            if(UserPermissions.hasPermission(Permissions.list_calendar))...[
              IListTileItem(
                title: l10n.team_calendar,
                icon: Icons.calendar_month,
                onPressed: () => context.pushRoute(
                  const CalendarListRoute(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
