import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class UsersShowGroupWidget extends StatelessWidget {
  const UsersShowGroupWidget({required this.group, super.key});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      borderRadius: BorderRadius.circular(mediumValue),
      child: Ink(
        padding: largePadding,
        decoration: BoxDecoration(
          color: context.container,
          borderRadius: mediumRadius,
        ),
        child: Row(
          spacing: mediumValue,
          children: [
            Icon(
              Icons.group,
              color: context.onSurface,
            ),
            Expanded(
              child: Text(
                group.title,
                style: context.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
