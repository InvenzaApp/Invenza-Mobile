import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/app/screens/app/helpers/app_navigation_destinations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = AppNavigationDestinations(context);
    return AutoTabsScaffold(
      routes: nav.getRoutesList(),
      bottomNavigationBuilder: (context, tabsRouter) {
        return NavigationBar(
          destinations: nav.getDestinationList(),
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: tabsRouter.setActiveIndex,
        );
      },
    );
  }
}
