import 'dart:async';

import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/core/list/cubit/list_cubit.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsListWidget extends StatelessWidget {
  const GroupsListWidget({required this.child, super.key});

  final Group child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final cubit = context.read<ListCubit<Group>>();
        final needUpdate =
            await context.pushRoute(GroupsShowRoute(resourceId: child.id));

        if(needUpdate == true){
          unawaited(cubit.initialize());
        }
      },
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
            Expanded(
              child: Text(
                child.title,
                style: context.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
