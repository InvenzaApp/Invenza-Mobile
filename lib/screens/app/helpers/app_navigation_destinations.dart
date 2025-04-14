import 'package:app/app/routing/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppNavigationDestinations {
  const AppNavigationDestinations(this.context);

  final BuildContext context;

  List<NavigationDestination> getDestinationList() => const [
        NavigationDestination(
          icon: Icon(Icons.dashboard_outlined),
          label: '',
          selectedIcon: Icon(Icons.dashboard),
        ),
        NavigationDestination(
          icon: Icon(Icons.task_outlined),
          label: '',
          selectedIcon: Icon(Icons.task),
        ),
        NavigationDestination(
          icon: Icon(Icons.supervised_user_circle_outlined),
          label: '',
          selectedIcon: Icon(Icons.supervised_user_circle),
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          label: '',
          selectedIcon: Icon(Icons.settings),
        ),
      ];

  List<PageRouteInfo<Object?>> getRoutesList() => const [
        DashboardRoute(),
        TasksRoute(),
        TeamRoute(),
        SettingsRoute(),
      ];
}
