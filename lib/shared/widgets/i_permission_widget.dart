import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/string_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/extensions/user_extension.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IPermissionWidget extends StatelessWidget {
  const IPermissionWidget({required this.permission, super.key});

  final Permissions permission;

  bool _hasAccess(User user) {
    return user.hasAccessToPermission(permission);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state.userResult!.maybeValue!;

    return InkWell(
      onTap: () {},
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
              _hasAccess(user) ? Icons.shield_outlined : Icons.lock,
              color: context.onSurface,
            ),
            Text(
              _hasAccess(user)
                  ? permission.getName(context)
                  : permission.getName(context).hashString(),
              style: context.bodyMedium.copyWith(
                decoration:
                    _hasAccess(user) ? null : TextDecoration.lineThrough,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
