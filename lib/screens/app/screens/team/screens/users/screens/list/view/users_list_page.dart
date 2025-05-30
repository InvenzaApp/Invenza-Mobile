import 'package:app/di.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/features/user/network/users_remote_data_source.dart';
import 'package:app/features/user/network/users_repository.dart';
import 'package:app/screens/app/screens/team/screens/users/screens/list/cubits/users_list_cubit.dart';
import 'package:app/screens/app/screens/team/screens/users/screens/list/widgets/users_list_widget.dart';
import 'package:app/shared/list_template/i_list_template.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UsersListPage extends StatelessWidget {
  const UsersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IListTemplate<User>(
      cubit: UsersListCubit(
        repository: UsersRepository(
          remoteDS: inject<UsersRemoteDataSource>(),
          title: context.l10n.users_list_app_bar,
        ),
      ),
      widget: (context, item) {
        return UsersListWidget(child: item);
      },
      createPermission: Permissions.add_user,
      listPermission: Permissions.list_user,
    );
  }
}
