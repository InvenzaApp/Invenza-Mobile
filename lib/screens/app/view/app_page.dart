import 'package:app/screens/app/helpers/app_navigation_destinations.dart';
import 'package:app/screens/app/widgets/i_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = AppNavigationDestinations(context);
    final destinations = nav.getDestinationList();

    return AutoTabsScaffold(
      routes: nav.getRoutesList(),
      bottomNavigationBuilder: (context, tabsRouter) {
        return INavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          destinations: destinations,
          tabsRouter: tabsRouter,
          onDestinationSelected: tabsRouter.setActiveIndex,
        );
      },
    );
  }
}
