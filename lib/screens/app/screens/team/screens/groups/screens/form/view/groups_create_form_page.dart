import 'package:app/di.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/group/network/groups_remote_data_source.dart';
import 'package:app/features/group/network/groups_repository.dart';
import 'package:app/features/group/use_case/groups_create_use_case.dart';
import 'package:app/screens/app/screens/team/screens/groups/screens/form/widgets/groups_form_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GroupsCreateFormPage extends StatelessWidget {
  const GroupsCreateFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GroupsFormWidget(
      useCase: GroupsCreateUseCase(
        cockpitRepository: GroupsRepository(
          title: context.l10n.groups_create_app_bar,
          remoteDS: inject<GroupsRemoteDataSource>(),
        ),
      ),
    );
  }
}
