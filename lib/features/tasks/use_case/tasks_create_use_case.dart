import 'package:app/core/use_case/use_case.dart';
import 'package:app/features/tasks/network/tasks_repository.dart';
import 'package:app/type_def/json.dart';

class TasksCreateUseCase extends CreateUseCase {
  TasksCreateUseCase({
    required this.cockpitRepository,
  });

  @override
  final TasksRepository cockpitRepository;

  @override
  Future<int> invoke(Json payload) async {
    return cockpitRepository.create(payload)
    .then((data) => data);
  }
}
