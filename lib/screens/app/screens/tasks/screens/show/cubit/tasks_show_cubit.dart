import 'package:app/features/tasks/network/tasks_repository.dart';
import 'package:app/screens/app/screens/tasks/screens/show/cubit/tasks_show_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksShowCubit extends Cubit<TasksShowState> {
  TasksShowCubit({
    required this.repository,
    required this.resourceId,
  }) : super(TasksShowPendingState()){
    _initialize();
  }

  final TasksRepository repository;
  final int resourceId;

  Future<void> _initialize() async{
    await fetch();
  }

  Future<void> fetch() async {
    final task = await repository.get(resourceId);

    emit(TasksShowLoadedState(task: task));
  }

  Future<void> delete() async{
    await repository.delete(resourceId);
  }
}
