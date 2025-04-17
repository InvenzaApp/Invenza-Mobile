import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppNavigationDestinations {
  const AppNavigationDestinations(this.context);

  final BuildContext context;

  List<NavigationDestination> getDestinationList() => [
        NavigationDestination(
          icon: Icon(Icons.dashboard_outlined, color: context.secondary),
          label: '',
          selectedIcon: Icon(Icons.dashboard, color: context.primary),
        ),
        NavigationDestination(
          icon: Icon(Icons.task_outlined, color: context.secondary),
          label: '',
          selectedIcon: Icon(Icons.task, color: context.primary),
        ),
        NavigationDestination(
          icon: Icon(
            Icons.supervised_user_circle_outlined,
            color: context.secondary,
          ),
          label: '',
          selectedIcon:
              Icon(Icons.supervised_user_circle, color: context.primary),
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined, color: context.secondary),
          label: '',
          selectedIcon: Icon(Icons.settings, color: context.primary),
        ),
      ];

  List<PageRouteInfo<Object?>> getRoutesList() => const [
        DashboardRoute(),
        TasksRoute(),
        TeamRoute(),
        SettingsRoute(),
      ];
}
