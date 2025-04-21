import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/core/list/cubit/list_cubit.dart';
import 'package:app/features/tasks/models/task.dart';
import 'package:app/features/tasks/network/tasks_repository.dart';

class TasksListCubit extends ListCubit<Task> {
  TasksListCubit({
    required this.repository,
  }) : super(createRoute: const TasksCreateFormRoute());

  @override
  final TasksRepository repository;

  @override
  Future<void> initialize() async {
    await fetch();
  }

  Future<void> fetch() async{
    super.emitState(isLoading: true);
    final result = await repository.getAll();
    super.emitState(isLoading: false, data: result);
  }
}
