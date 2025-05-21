import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppNavigationDestinations {
  const AppNavigationDestinations(this.context);

  final BuildContext context;

  List<NavigationDestination> getDestinationList() => [
        NavigationDestination(
          icon: Icon(Icons.task_outlined, color: context.secondary),
          label: context.l10n.nav_bar_tasks,
          selectedIcon: Icon(Icons.task, color: context.primary),
        ),
        NavigationDestination(
          icon: Icon(
            Icons.supervised_user_circle_outlined,
            color: context.secondary,
          ),
          label: context.l10n.nav_bar_team,
          selectedIcon:
              Icon(Icons.supervised_user_circle, color: context.primary),
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined, color: context.secondary),
          label: context.l10n.nav_bar_settings,
          selectedIcon: Icon(Icons.settings, color: context.primary),
        ),
      ];

  List<PageRouteInfo<Object?>> getRoutesList() => const [
        TasksListRoute(),
        TeamRoute(),
        SettingsRoute(),
      ];
}
