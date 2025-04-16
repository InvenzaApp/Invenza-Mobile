import 'package:app/core/cockpit_repo/cockpit_repo.dart';
import 'package:app/screens/app/screens/tasks/screens/form/create/repo/tasks_remote_data_source.dart';
import 'package:app/type_def/json.dart';

class TasksRepository extends CockpitRepo {
  TasksRepository({
    required this.title,
    required this.remoteDS,
    required this.useCase,
  });

  @override
  final UseCase useCase;

  @override
  String get baseUrl => '/api/tasks';

  @override
  final String title;

  @override
  final TasksRemoteDataSource remoteDS;

  @override
  Future<void> create(Json payload) async{
    await remoteDS.create(payload);
  }
}
