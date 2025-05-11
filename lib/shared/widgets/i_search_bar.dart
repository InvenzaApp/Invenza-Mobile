import 'package:app/extensions/app_localizations.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class ISearchBar extends StatelessWidget {
  const ISearchBar({
    required this.onChanged,
    super.key,
  });

  final void Function(String query) onChanged;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      elevation: WidgetStateProperty.resolveWith(
            (states) {
          return 0;
        },
      ),
      hintText: context.l10n.search,
      leading: const Icon(Icons.search),
      padding: WidgetStateProperty.resolveWith(
            (states) {
          return mediumHorizontalPadding;
        },
      ),
      onChanged: onChanged,
    );
  }
}
