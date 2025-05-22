import 'package:flutter/material.dart';

class INavigationBar extends StatelessWidget {
  const INavigationBar({
    required this.selectedIndex,
    required this.destinations,
    required this.onDestinationSelected,
    super.key,
  });

  final int selectedIndex;
  final List<NavigationDestination> destinations;
  final void Function(int) onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: destinations,
      onDestinationSelected: onDestinationSelected,
      selectedIndex: selectedIndex,
    );
  }
}
