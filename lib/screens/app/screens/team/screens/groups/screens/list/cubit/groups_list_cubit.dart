import 'package:app/features/group/network/groups_repository.dart';
import 'package:app/screens/app/screens/team/screens/groups/screens/list/cubit/groups_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsListCubit extends Cubit<GroupsListState> {
  GroupsListCubit({
    required this.repository,
  }) : super(const GroupsListState()){
    _initialize();
  }

  final GroupsRepository repository;

  Future<void> _initialize() async{
    await fetch();
  }

  Future<void> fetch() async{
    final groups = await repository.getAll();

    emit(GroupsListState(groupsList: groups));
  }
}
