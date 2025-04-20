import 'package:app/core/result/result.dart';
import 'package:app/features/tasks/models/task.dart';
import 'package:equatable/equatable.dart';

class TasksListState extends Equatable {
  const TasksListState({
    this.result,
    this.isLoading = false,
  });

  TasksListState copyWith({
    Result<List<Task>>? result,
    bool? isLoading,
  }) =>
      TasksListState(
        result: result ?? this.result,
        isLoading: isLoading ?? this.isLoading,
      );

  final Result<List<Task>>? result;
  final bool isLoading;

  @override
  List<Object?> get props => [result, isLoading];
}
