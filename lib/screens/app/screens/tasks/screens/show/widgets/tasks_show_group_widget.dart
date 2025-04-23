import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class TasksShowGroupWidget extends StatelessWidget {
  const TasksShowGroupWidget({
    required this.group,
    super.key,
  });

  final Group group;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushRoute(GroupsShowRoute(resourceId: group.id)),
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
                Icons.group,
                color: context.onPrimary,
              ),
            ),
            Text(
              group.title,
              style: context.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
