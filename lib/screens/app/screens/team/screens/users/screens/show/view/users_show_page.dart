import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/di.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/features/user/network/users_remote_data_source.dart';
import 'package:app/features/user/network/users_repository.dart';
import 'package:app/screens/app/screens/team/screens/users/screens/show/cubits/users_show_cubit.dart';
import 'package:app/screens/app/screens/team/screens/users/screens/show/widgets/users_show_group_widget.dart';
import 'package:app/shared/show_template/i_show_template.dart';
import 'package:app/shared/widgets/i_card/i_card.dart';
import 'package:app/shared/widgets/i_permission_widget.dart';
import 'package:app/variables.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UsersShowPage extends StatelessWidget {
  const UsersShowPage({@pathParam required this.resourceId, super.key});

  final int resourceId;
  static final userCubit = inject<UserCubit>();

  bool isDeleteAndEditEnabled() {
    if (userCubit.state.organizationResult?.maybeValue?.id == resourceId) {
      return false;
    }

    if (userCubit.state.userResult?.maybeValue?.id == resourceId) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return IShowTemplate<User>(
      cubit: UsersShowCubit(
        resourceId: resourceId,
        repository: UsersRepository(
          remoteDS: inject<UsersRemoteDataSource>(),
          title: l10n.users_show_app_bar,
        ),
      ),
      deleteEnabled: isDeleteAndEditEnabled(),
      editEnabled: isDeleteAndEditEnabled(),
      builder: (context, cubit) {
        final user = cubit.data;

        return Padding(
          padding: mediumPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ICard(
                  children: [
                    ICardItem(
                      label: l10n.users_show_name,
                      value: user.name,
                    ),
                    ICardItem(
                      label: l10n.users_show_lastname,
                      value: user.lastname,
                    ),
                    ICardItem(
                      label: l10n.users_show_email,
                      value: user.email,
                    ),
                    if (user.locked) ...[
                      ICardItem(
                        label: l10n.locked,
                        value: l10n.yes,
                      ),
                    ],
                    if (user.admin) ...[
                      ICardItem(
                        label: l10n.users_show_administrator,
                        value: l10n.yes,
                      ),
                    ],
                  ],
                ),
                SizedBox(height: largeValue),
                if (user.groups?.isNotEmpty ?? false) ...[
                  Text(
                    l10n.users_show_groups,
                    style: context.bodyMedium,
                  ),
                  SizedBox(height: smallValue),
                  Column(
                    spacing: smallValue,
                    children: user.groups!.map((group) {
                      return UsersShowGroupWidget(group: group);
                    }).toList(),
                  ),
                  SizedBox(height: largeValue),
                ],
                if (user.permissions.isNotEmpty) ...[
                  Text(
                    l10n.permissions,
                    style: context.bodyMedium,
                  ),
                  SizedBox(height: smallValue),
                  Column(
                    spacing: smallValue,
                    children: user.permissions.map((permission) {
                      return IPermissionWidget(permission: permission);
                    }).toList(),
                  ),
                  SizedBox(height: largeValue),
                ],
              ],
            ),
          ),
        );
      },
      updatePermission: Permissions.update_user,
      deletePermission: Permissions.delete_user,
    );
  }
}
