import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/core/show/cubit/show_cubit.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/features/group/network/groups_repository.dart';

class GroupsShowCubit extends ShowCubit<Group> {
  GroupsShowCubit({
    required this.repository,
    required this.resourceId,
  }) : super(editRoute: GroupsUpdateFormRoute(resourceId: resourceId));

  @override
  Future<void> delete() async {}

  @override
  Future<void> initialize() async {
    await fetch();
  }

  Future<void> fetch() async {
    super.emitState(isLoading: true);
    final result = await repository.get(resourceId);
    super.emitState(data: result, isLoading: false);
  }

  @override
  final GroupsRepository repository;

  @override
  final int resourceId;
}
