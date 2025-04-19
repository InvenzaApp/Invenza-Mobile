import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/core/show/cubit/show_cubit.dart';
import 'package:app/features/tasks/models/task.dart';
import 'package:app/features/tasks/network/tasks_repository.dart';

class TasksShowCubit extends ShowCubit<Task> {
  TasksShowCubit({
    required this.repository,
    required this.resourceId,
  }) : super(editRoute: TasksUpdateFormRoute(resourceId: resourceId));

  @override
  final int resourceId;

  @override
  final TasksRepository repository;

  @override
  Future<void> initialize() async {
    await fetch();
  }

  Future<void> fetch() async{
    super.emitState(isLoading: true);
    final result = await repository.get(resourceId);
    super.emitState(data: result, isLoading: false);
  }
}
