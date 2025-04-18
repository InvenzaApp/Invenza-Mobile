import 'package:app/features/group/network/groups_repository.dart';
import 'package:app/screens/app/screens/team/screens/groups/screens/show/cubit/groups_show_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsShowCubit extends Cubit<GroupsShowState> {
  GroupsShowCubit({
    required this.repository,
    required this.resourceId,
  }) : super(const GroupsShowState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    await fetch();
  }

  Future<void> fetch() async{
    final result = await repository.get(resourceId);

    emit(GroupsShowState(result: result));
  }

  final GroupsRepository repository;
  final int resourceId;
}
