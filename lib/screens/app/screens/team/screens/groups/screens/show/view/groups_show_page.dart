import 'dart:async';

import 'package:app/di.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/confirm_extension.dart';
import 'package:app/features/group/network/groups_remote_data_source.dart';
import 'package:app/features/group/network/groups_repository.dart';
import 'package:app/screens/app/screens/team/screens/groups/screens/show/cubit/groups_show_cubit.dart';
import 'package:app/screens/app/screens/team/screens/groups/screens/show/cubit/groups_show_state.dart';
import 'package:app/screens/app/screens/team/screens/groups/screens/show/widgets/groups_show_widget.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_card/i_card.dart';
import 'package:app/shared/widgets/i_error_widget.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class GroupsShowPage extends StatelessWidget implements AutoRouteWrapper {
  const GroupsShowPage({
    @pathParam required this.resourceId,
    super.key,
  });

  final int resourceId;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupsShowCubit(
        repository: GroupsRepository(
          remoteDS: inject<GroupsRemoteDataSource>(),
        ),
        resourceId: resourceId,
      ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: iAppBar(
        context: context,
        title: l10n.groups_show_app_bar,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: context.error),
            onPressed: () async {
              final cubit = context.read<GroupsShowCubit>();

              final needUpdate = await context
                  .showConfirm(l10n.groups_show_delete_alert);

              if (needUpdate != null && needUpdate) {
                unawaited(cubit.delete());
                if (context.mounted) {
                  await context.maybePop(true);
                }
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),
      body: BlocBuilder<GroupsShowCubit, GroupsShowState>(
        builder: (context, state) {
          if (state.result?.isError ?? true) {
            return const IErrorWidget();
          }

          final group = state.result!.maybeValue!;

          return Padding(
            padding: mediumPadding,
            child: Column(
              spacing: mediumValue,
              children: [
                ICard(
                  children: [
                    ICardItem(
                      label: l10n.groups_show_name,
                      value: group.name,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: group.usersList!.length,
                    itemBuilder: (context, index) {
                      final user = group.usersList![index];

                      return GroupsShowWidget(user: user);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
