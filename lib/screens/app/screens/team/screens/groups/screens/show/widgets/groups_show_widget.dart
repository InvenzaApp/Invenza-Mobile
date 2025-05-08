import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class GroupsShowWidget extends StatelessWidget {
  const GroupsShowWidget({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
            Icon(
              Icons.person,
              color: context.onSurface,
            ),
            Expanded(
              child: Text(
                '${user.name} ${user.lastname}',
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
