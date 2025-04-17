import 'package:app/core/cockpit_repository/cockpit_repository.dart';
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
  Future<int> create(Json payload) async {
    return remoteDS.create(payload)
        .then((data) => data);
  }

  @override
  Future<List<Task>> getAll() async {
    return remoteDS.getAll().then(
          (data) => data.map((item) => Task.fromJson(item as Json)).toList(),
        );
  }

  @override
  Future<Task> get(int resourceId) async{
    return remoteDS.get(resourceId)
        .then((data) => Task.fromJson(data as Json));
  }

  @override
  Future<void> delete(int resourceId) async {
    await remoteDS.delete(resourceId);
  }

  @override
  Future<int> update(int resourceId, Json payload) async{
    return remoteDS.update(resourceId, payload)
        .then((data) => data);
  }
}
