import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/cubit/user_cubit/user_state.dart';
import 'package:app/di.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/user/network/users_remote_data_source.dart';
import 'package:app/features/user/network/users_repository.dart';
import 'package:app/screens/app/screens/team/screens/users/screens/show/cubits/users_show_cubit.dart';
import 'package:app/shared/show_template/i_show_template.dart';
import 'package:app/shared/widgets/i_card/i_card.dart';
import 'package:app/variables.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class UsersShowPage extends StatelessWidget {
  const UsersShowPage({@pathParam required this.resourceId, super.key});

  final int resourceId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return IShowTemplate(
          cubit: UsersShowCubit(
            resourceId: resourceId,
            repository: UsersRepository(
              remoteDS: inject<UsersRemoteDataSource>(),
              title: l10n.users_show_app_bar,
            ),
          ),
          deleteEnabled:
              state.organizationResult?.maybeValue?.admin.id != resourceId,
          builder: (context, cubit) {
            final user = cubit.data;

            return Padding(
              padding: mediumPadding,
              child: Column(
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
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
