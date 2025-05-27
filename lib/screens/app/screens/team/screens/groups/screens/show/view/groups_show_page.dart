import 'package:app/di.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/features/group/network/groups_remote_data_source.dart';
import 'package:app/features/group/network/groups_repository.dart';
import 'package:app/screens/app/screens/team/screens/groups/screens/show/cubit/groups_show_cubit.dart';
import 'package:app/screens/app/screens/team/screens/groups/screens/show/widgets/groups_show_widget.dart';
import 'package:app/shared/show_template/i_show_template.dart';
import 'package:app/shared/widgets/i_lock_widget.dart';
import 'package:app/variables.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GroupsShowPage extends StatelessWidget {
  const GroupsShowPage({required this.resourceId, super.key});

  final int resourceId;

  @override
  Widget build(BuildContext context) {
    return IShowTemplate<Group>(
      cubit: GroupsShowCubit(
        repository: GroupsRepository(
          remoteDS: inject<GroupsRemoteDataSource>(),
          title: context.l10n.groups_show_app_bar,
        ),
        resourceId: resourceId,
      ),
      builder: (context, cubit) {
        final group = cubit.data;

        return Padding(
          padding: mediumPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IShowTitleWidget(
                  text: group.title,
                ),
                if(group.locked)...[
                  const ILockWidget(),
                ],
                SizedBox(height: largeValue),
                if(group.usersList!.isNotEmpty)...[
                  Text(
                    context.l10n.groups_show_users,
                    style: context.bodyMedium,
                  ),
                  SizedBox(height: smallValue),
                  Column(
                    spacing: smallValue,
                    children: group.usersList!.map((item){
                      return GroupsShowWidget(user: item);
                    }).toList(),
                  ),
                  SizedBox(height: largeValue),
                ],
              ],
            ),
          ),
        );
      }, updatePermission: Permissions.update_group,
      deletePermission: Permissions.delete_group,
    );
  }
}
