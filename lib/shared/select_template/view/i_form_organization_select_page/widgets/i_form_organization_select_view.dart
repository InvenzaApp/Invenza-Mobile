import 'package:app/extensions/color_extension.dart';
import 'package:app/features/organization/models/organization.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IFormOrganizationSelectView extends StatelessWidget {
  const IFormOrganizationSelectView({
    required this.isSelected,
    required this.organization,
    required this.onChanged,
    super.key,
  });

  final bool isSelected;
  final Organization organization;
  final void Function(bool selected) onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!isSelected),
      borderRadius: BorderRadius.circular(mediumValue),
      child: Ink(
        padding: xLargePadding,
        decoration: BoxDecoration(
          color: isSelected ? context.primaryContainer : context.container,
          borderRadius: mediumRadius,
        ),
        child: Row(
          spacing: mediumValue,
          children: [
            Icon(
              isSelected
                  ? Icons.check_circle
                  : Icons.business,
            ),
            Text(
              organization.title,
            ),
          ],
        ),
      ),
    );
  }
}
