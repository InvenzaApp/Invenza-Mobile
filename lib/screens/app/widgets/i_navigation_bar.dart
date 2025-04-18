import 'package:app/extensions/color_extension.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class INavigationBar extends StatelessWidget {
  const INavigationBar({
    required this.selectedIndex,
    required this.destinations,
    required this.tabsRouter,
    required this.onDestinationSelected,
    super.key,
  });

  final int selectedIndex;
  final List<NavigationDestination> destinations;
  final TabsRouter tabsRouter;
  final void Function(int) onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: mediumPadding,
        child: Ink(
          padding: smallPadding,
          decoration: BoxDecoration(
            color: context.container,
            borderRadius: mediumRadius,
          ),
          child: Row(
            spacing: smallValue,
            children: destinations.asMap().entries.map(
                  (entry) {
                final index = entry.key;
                final item = entry.value;
                final selected = selectedIndex == index;

                return Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(mediumValue),
                    onTap: () => onDestinationSelected(index),
                    child: Padding(
                      padding: mediumPadding,
                      child: selected ? item.selectedIcon! : item.icon,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
