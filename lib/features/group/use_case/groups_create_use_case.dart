import 'package:app/core/use_case/use_case.dart';
import 'package:app/features/group/network/groups_repository.dart';
import 'package:app/type_def/json.dart';

class GroupsCreateUseCase extends CreateUseCase {
  GroupsCreateUseCase({
    required this.cockpitRepository,
  });

  @override
  final GroupsRepository cockpitRepository;

  @override
  Future<int> invoke(Json payload) async {
    return cockpitRepository.create(payload).then((data) => data);
  }
}
