import 'package:app/core/cockpit_repository/cockpit_repository.dart';
import 'package:app/core/result/result.dart';
import 'package:app/extensions/result_extension.dart';
import 'package:app/features/tasks/models/task.dart';
import 'package:app/features/tasks/network/tasks_remote_data_source.dart';
import 'package:app/type_def/json.dart';

class TasksRepository extends CockpitRepository {
  TasksRepository({
    required this.remoteDS,
    this.title,
  });

  @override
  final String? title;

  @override
  final TasksRemoteDataSource remoteDS;

  @override
  Future<Result<int>> create(Json payload) async {
    return remoteDS.create(payload).asResult<int>();
  }

  @override
  Future<Result<List<Task>>> getAll() async {
    return remoteDS.getAll().asListResult<Task>(fromJson: Task.fromJson);
  }

  @override
  Future<Result<Task>> get(int resourceId) async {
    return remoteDS.get(resourceId).asResult<Task>(fromJson: Task.fromJson);
  }

  @override
  Future<void> delete(int resourceId) async {
    await remoteDS.delete(resourceId);
  }

  @override
  Future<Result<int>> update(int resourceId, Json payload) async {
    return remoteDS.update(resourceId, payload).asResult<int>();
  }
}
