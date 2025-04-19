import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/di.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/group/network/groups_remote_data_source.dart';
import 'package:app/features/group/network/groups_repository.dart';
import 'package:app/features/group/use_case/groups_update_use_case.dart';
import 'package:app/screens/app/screens/team/screens/groups/screens/form/widgets/groups_form_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GroupsUpdateFormPage extends StatelessWidget implements AutoRouteWrapper {
  const GroupsUpdateFormPage({required this.resourceId, super.key});

  final int resourceId;

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return GroupsFormWidget(
      useCase: GroupsUpdateUseCase(
        cockpitRepository: GroupsRepository(
          remoteDS: inject<GroupsRemoteDataSource>(),
          title: context.l10n.groups_update_app_bar,
        ),
        resourceId: resourceId,
        userCubit: inject<UserCubit>(),
      ),
    );
  }
}
