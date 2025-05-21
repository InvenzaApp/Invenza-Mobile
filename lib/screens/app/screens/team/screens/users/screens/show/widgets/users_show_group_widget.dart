import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/extensions/user_extension.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersShowGroupWidget extends StatelessWidget {
  const UsersShowGroupWidget({required this.group, super.key});

  final Group group;

  bool _hasAccess(User user) {
    return user.hasAccessToGroup(group.id);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state.userResult!.maybeValue!;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(mediumValue),
      child: Ink(
        padding: xLargePadding,
        decoration: BoxDecoration(
          color: context.container,
          borderRadius: mediumRadius,
        ),
        child: Row(
          spacing: mediumValue,
          children: [
            Icon(
              _hasAccess(user) ? Icons.group : Icons.lock,
              color: context.onSurface,
            ),
            Expanded(
              child: Text(
                _hasAccess(user) ? group.title : group.id.toString(),
                style: context.bodyMedium.copyWith(
                  decoration:
                      _hasAccess(user) ? null : TextDecoration.lineThrough,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
