import 'package:app/features/tasks/models/task.dart';
import 'package:equatable/equatable.dart';

class TasksListState extends Equatable{
  const TasksListState({
    this.tasksList = const [],
  });

  final List<Task> tasksList;

  @override
  List<Object?> get props => [tasksList];
}
