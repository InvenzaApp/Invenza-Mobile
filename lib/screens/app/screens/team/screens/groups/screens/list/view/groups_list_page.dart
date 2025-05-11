// import 'dart:async';
//
// import 'package:app/app/routing/app_router.gr.dart';
// import 'package:app/di.dart';
// import 'package:app/extensions/app_localizations.dart';
// import 'package:app/features/group/network/groups_remote_data_source.dart';
// import 'package:app/features/group/network/groups_repository.dart';
// import 'package:app/screens/app/screens/team/screens/groups/screens/list/cubit/groups_list_cubit.dart';
// import 'package:app/screens/app/screens/team/screens/groups/screens/list/cubit/groups_list_state.dart';
// import 'package:app/screens/app/screens/team/screens/groups/screens/list/widgets/groups_list_widget.dart';
// import 'package:app/shared/widgets/i_app_bar.dart';
// import 'package:app/shared/widgets/i_error_widget.dart';
// import 'package:app/shared/widgets/i_loading_widget.dart';
// import 'package:app/variables.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// @RoutePage()
// class GroupsListPage extends StatelessWidget implements AutoRouteWrapper {
//   const GroupsListPage({super.key});
//
//   @override
//   Widget wrappedRoute(BuildContext context) {
//     return BlocProvider(
//       create: (_) => GroupsListCubit(
//         repository: GroupsRepository(
//           remoteDS: inject<GroupsRemoteDataSource>(),
//         ),
//       ),
//       child: this,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: iAppBar(
//         context: context,
//         title: context.l10n.groups_list_app_bar,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final cubit = context.read<GroupsListCubit>();
//           final needUpdate =
//               await context.pushRoute(const GroupsCreateFormRoute());
//
//           if (needUpdate == true) {
//             unawaited(cubit.fetch());
//           }
//         },
//         child: const Icon(Icons.add),
//       ),
//       body: BlocBuilder<GroupsListCubit, GroupsListState>(
//         builder: (context, state) => switch (state.isLoading) {
//           true => const ILoadingWidget(),
//           false => (state.groupsList?.isEmpty ?? true)
//               ? IErrorWidget(
//                   icon: Icons.group_off_sharp,
//                   title: context.l10n.groups_list_no_groups_title,
//                   showSubtitle: false,
//                 )
//               : Padding(
//                   padding: mediumPadding,
//                   child: RefreshIndicator(
//                     onRefresh: () async =>
//                         context.read<GroupsListCubit>().fetch(),
//                     child: ListView.builder(
//                       itemCount: state.groupsList!.length,
//                       itemBuilder: (context, index) {
//                         final group = state.groupsList![index];
//                         return Column(
//                           children: [
//                             GroupsListWidget(child: group),
//                             SizedBox(height: mediumValue),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//         },
//       ),
//     );
//   }
// }

import 'package:app/di.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/features/group/network/groups_remote_data_source.dart';
import 'package:app/features/group/network/groups_repository.dart';
import 'package:app/screens/app/screens/team/screens/groups/screens/list/cubit/groups_list_cubit.dart';
import 'package:app/screens/app/screens/team/screens/groups/screens/list/widgets/groups_list_widget.dart';
import 'package:app/shared/list_template/i_list_template.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GroupsListPage extends StatelessWidget {
  const GroupsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IListTemplate<Group>(
      cubit: GroupsListCubit(
        repository: GroupsRepository(
          remoteDS: inject<GroupsRemoteDataSource>(),
          title: context.l10n.groups_list_app_bar,
        ),
      ),
      widget: (context, item) {
        return GroupsListWidget(child: item);
      },
      createPermission: Permissions.add_group,
      listPermission: Permissions.list_group,
    );
  }
}
