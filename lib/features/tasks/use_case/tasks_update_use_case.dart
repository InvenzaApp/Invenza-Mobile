import 'package:app/core/use_case/use_case.dart';
import 'package:app/features/tasks/network/tasks_repository.dart';
import 'package:app/type_def/json.dart';

class TasksUpdateUseCase extends UpdateUseCase{
  TasksUpdateUseCase({
    required this.resourceId,
    required this.cockpitRepository,
  });

  @override
  final TasksRepository cockpitRepository;

  @override
  final int resourceId;

  @override
  Future<int> invoke(Json payload) async {
    return cockpitRepository.update(resourceId, payload).then((data) => data);
  }
}
