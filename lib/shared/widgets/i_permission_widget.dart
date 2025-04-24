import 'package:app/enums/permissions.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IPermissionWidget extends StatelessWidget {
  const IPermissionWidget({required this.permission, super.key});

  final Permissions permission;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: mediumPadding,
      decoration: BoxDecoration(
        color: context.container,
        borderRadius: mediumRadius,
      ),
      child: Row(
        spacing: mediumValue,
        children: [
          Container(
            padding: smallPadding,
            decoration: BoxDecoration(
              color: context.primary,
              borderRadius: smallRadius,
            ),
            child: Icon(
              Icons.shield_outlined,
              color: context.onPrimary,
            ),
          ),
          Text(
            permission.getName(context),
          ),
        ],
      ),
    );
  }
}
