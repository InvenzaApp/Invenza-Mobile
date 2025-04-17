import 'package:app/features/tasks/network/tasks_repository.dart';
import 'package:app/screens/app/screens/tasks/cubit/tasks_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksListCubit extends Cubit<TasksListState> {
  TasksListCubit({
    required this.repository,
  }) : super(const TasksListState()) {
    _initialize();
  }

  final TasksRepository repository;

  Future<void> _initialize() async {
    await fetch();
  }

  Future<void> fetch() async {
    final result = await repository.getAll();

    emit(
      TasksListState(
        result: result,
      ),
    );
  }
}
