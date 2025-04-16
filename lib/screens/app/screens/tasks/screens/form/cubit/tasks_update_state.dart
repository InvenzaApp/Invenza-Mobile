import 'package:app/features/tasks/models/task.dart';
import 'package:equatable/equatable.dart';

class TasksUpdateState extends Equatable{
  const TasksUpdateState({
    this.resources,
  });

  final Task? resources;

  @override
  List<Object?> get props => [resources];
}
