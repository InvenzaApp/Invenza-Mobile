import 'package:app/features/tasks/models/task.dart';
import 'package:equatable/equatable.dart';

class TasksShowState extends Equatable {
  const TasksShowState({
    this.task,
    this.isLoading = false,
  });

  TasksShowState copyWith({
    Task? task,
    bool? isLoading,
  }) {
    return TasksShowState(
      task: task ?? this.task,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final Task? task;
  final bool isLoading;

  @override
  List<Object?> get props => [task];
}
