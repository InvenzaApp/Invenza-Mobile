import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/core/list/cubit/list_cubit.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/features/group/network/groups_repository.dart';

class GroupsListCubit extends ListCubit<Group> {
  GroupsListCubit({
    required this.repository,
  }) : super(createRoute: const GroupsCreateFormRoute());

  @override
  final GroupsRepository repository;

  @override
  Future<void> initialize() async {
    await fetch();
  }

  Future<void> fetch() async{
    super.emitState(isLoading: true);
    final result = await repository.getAll();
    super.emitState(data: result, isLoading: false);
  }
}
