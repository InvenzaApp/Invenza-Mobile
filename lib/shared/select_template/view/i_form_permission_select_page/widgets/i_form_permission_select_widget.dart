import 'package:app/enums/permissions.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IFormPermissionSelectWidget extends StatelessWidget {
  const IFormPermissionSelectWidget({
    required this.isSelected,
    required this.permission,
    required this.onChanged,
    super.key,
  });

  final bool isSelected;
  final Permissions permission;
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
                  : permission.getPermissionTypeIcon(),
            ),
            Text(
              permission.getName(context),
            ),
          ],
        ),
      ),
    );
  }
}
