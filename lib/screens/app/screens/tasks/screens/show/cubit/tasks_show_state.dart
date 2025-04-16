import 'package:app/features/tasks/models/task.dart';
import 'package:equatable/equatable.dart';

abstract class TasksShowState{}

class TasksShowPendingState extends TasksShowState {}

class TasksShowLoadedState extends TasksShowState with EquatableMixin{
  TasksShowLoadedState({
    required this.task,
  });

  final Task task;

  @override
  List<Object?> get props => [task];
}
