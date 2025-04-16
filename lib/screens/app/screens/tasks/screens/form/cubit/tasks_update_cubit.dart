import 'package:app/features/tasks/network/tasks_repository.dart';
import 'package:app/screens/app/screens/tasks/screens/form/cubit/tasks_update_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksUpdateCubit extends Cubit<TasksUpdateState>{
  TasksUpdateCubit({
    required this.resourceId,
    required this.repository,
}) : super(const TasksUpdateState());

  final TasksRepository repository;
  final int resourceId;
}
