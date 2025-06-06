import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/di.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/user/network/users_remote_data_source.dart';
import 'package:app/features/user/network/users_repository.dart';
import 'package:app/features/user/use_case/users_update_use_case.dart';
import 'package:app/screens/app/screens/team/screens/users/screens/form/widgets/users_form_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UsersUpdateFormPage extends StatelessWidget {
  const UsersUpdateFormPage({required this.resourceId, super.key});

  final int resourceId;

  @override
  Widget build(BuildContext context) {
    return UsersFormWidget(
      useCase: UsersUpdateUseCase(
        cockpitRepository: UsersRepository(
          remoteDS: inject<UsersRemoteDataSource>(),
          title: context.l10n.users_update_app_bar,
        ),
        userCubit: inject<UserCubit>(),
        resourceId: resourceId,
      ),
    );
  }
}
