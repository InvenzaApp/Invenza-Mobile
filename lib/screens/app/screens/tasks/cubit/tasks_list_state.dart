import 'package:app/core/result/result.dart';
import 'package:app/enums/api_messages.dart';
import 'package:app/features/tasks/models/task.dart';
import 'package:equatable/equatable.dart';

class TasksListState extends Equatable {
  const TasksListState({
    this.result,
  });

  TasksListState copyWith({
    Result<List<Task>>? result,
    ApiMessages? error,
  }) =>
      TasksListState(
        result: result ?? this.result,
      );

  final Result<List<Task>>? result;

  @override
  List<Object?> get props => [result];
}
