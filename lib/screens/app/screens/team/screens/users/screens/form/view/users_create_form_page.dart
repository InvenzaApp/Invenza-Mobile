import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/di.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/user/network/users_remote_data_source.dart';
import 'package:app/features/user/network/users_repository.dart';
import 'package:app/features/user/use_case/users_create_use_case.dart';
import 'package:app/screens/app/screens/team/screens/users/screens/form/widgets/users_form_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UsersCreateFormPage extends StatelessWidget {
  const UsersCreateFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return UsersFormWidget(
      useCase: UsersCreateUseCase(
        cockpitRepository: UsersRepository(
          remoteDS: inject<UsersRemoteDataSource>(),
          title: context.l10n.users_create_app_bar,
        ),
        userCubit: inject<UserCubit>(),
      ),
    );
  }
}
