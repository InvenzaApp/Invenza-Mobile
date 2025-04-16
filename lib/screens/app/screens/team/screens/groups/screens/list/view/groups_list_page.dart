import 'package:app/di.dart';
import 'package:app/features/group/network/groups_remote_data_source.dart';
import 'package:app/features/group/network/groups_repository.dart';
import 'package:app/screens/app/screens/team/screens/groups/screens/list/cubit/groups_list_cubit.dart';
import 'package:app/screens/app/screens/team/screens/groups/screens/list/cubit/groups_list_state.dart';
import 'package:app/screens/app/screens/team/screens/groups/screens/list/widgets/groups_list_widget.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class GroupsListPage extends StatelessWidget implements AutoRouteWrapper {
  const GroupsListPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupsListCubit(
        repository: GroupsRepository(
          remoteDS: inject<GroupsRemoteDataSource>(),
        ),
      ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: iAppBar(
        context: context,
        title: 'Grupy',
      ),
      body: BlocBuilder<GroupsListCubit, GroupsListState>(
        builder: (context, state) {
          return Padding(
            padding: mediumPadding,
            child: RefreshIndicator(
              onRefresh: () async => context.read<GroupsListCubit>().fetch(),
              child: ListView.builder(
                itemCount: state.groupsList.length,
                itemBuilder: (context, index) {
                  final group = state.groupsList[index];
                  return Column(
                    children: [
                      GroupsListWidget(child: group),
                      SizedBox(height: mediumValue),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
