import 'package:app/app/routing/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppNavigationDestinations {
  const AppNavigationDestinations(this.context);

  final BuildContext context;

  List<NavigationDestination> getDestinationList() => const [
        NavigationDestination(
          icon: Icon(Icons.dashboard),
          label: "Dashboard",
        ),
        NavigationDestination(
          icon: Icon(Icons.task),
          label: "Tasks",
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: "Users",
        ),
      ];

  List<PageRouteInfo<Object?>> getRoutesList() => const [
        DashboardRoute(),
        TasksRoute(),
        UsersRoute(),
      ];
}
