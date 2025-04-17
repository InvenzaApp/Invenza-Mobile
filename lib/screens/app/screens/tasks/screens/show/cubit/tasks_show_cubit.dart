import 'package:app/features/tasks/network/tasks_repository.dart';
import 'package:app/screens/app/screens/tasks/screens/show/cubit/tasks_show_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksShowCubit extends Cubit<TasksShowState> {
  TasksShowCubit({
    required this.repository,
    required this.resourceId,
  }) : super(const TasksShowState()) {
    _initialize();
  }

  final TasksRepository repository;
  final int resourceId;

  Future<void> _initialize() async {
    await fetch();
  }

  Future<void> fetch() async {
    emit(state.copyWith(isLoading: true));
    final result = await repository.get(resourceId);

    emit(
      TasksShowState(
        task: result.isSuccess ? result.maybeValue! : null,
      ),
    );
  }

  Future<void> delete() async {
    await repository.delete(resourceId);
  }
}
