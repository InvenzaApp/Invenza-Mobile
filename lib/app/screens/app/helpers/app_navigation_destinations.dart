import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppNavigationDestinations {
  const AppNavigationDestinations(this.context);

  final BuildContext context;

  List<NavigationDestination> getDestinationList() => [
        NavigationDestination(
          icon: const Icon(Icons.dashboard),
          label: context.l10n.nav_bar_dashboard,
        ),
        NavigationDestination(
          icon: const Icon(Icons.task),
          label: context.l10n.nav_bar_tasks,
        ),
        NavigationDestination(
          icon: const Icon(Icons.supervised_user_circle),
          label: context.l10n.nav_bar_team,
        ),
      ];

  List<PageRouteInfo<Object?>> getRoutesList() => const [
        DashboardRoute(),
        TasksRoute(),
        TeamRoute(),
      ];
}
