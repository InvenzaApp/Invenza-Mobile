import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class GroupsListWidget extends StatelessWidget {
  const GroupsListWidget({required this.child, super.key});

  final Group child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      borderRadius: BorderRadius.circular(mediumValue),
      child: Ink(
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
                Icons.groups,
                color: context.onPrimary,
              ),
            ),
            Text(
              child.name,
              style: context.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
