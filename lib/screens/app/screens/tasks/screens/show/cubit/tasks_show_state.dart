import 'package:app/core/result/result.dart';
import 'package:app/features/tasks/models/task.dart';
import 'package:equatable/equatable.dart';

class TasksShowState extends Equatable {
  const TasksShowState({
    this.result,
    this.isLoading = false,
  });

  TasksShowState copyWith({
    Result<Task>? result,
    bool? isLoading,
  }) {
    return TasksShowState(
      result: result ?? this.result,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final Result<Task>? result;
  final bool isLoading;

  @override
  List<Object?> get props => [result, isLoading];
}
