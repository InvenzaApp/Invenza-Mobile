import 'package:app/core/result/result.dart';
import 'package:app/core/use_case/use_case.dart';
import 'package:app/features/user/network/users_repository.dart';
import 'package:app/type_def/json.dart';

class UsersUpdateUseCase extends UpdateUseCase {
  UsersUpdateUseCase({
    required this.cockpitRepository,
    required this.resourceId,
  });

  @override
  final UsersRepository cockpitRepository;

  @override
  final int resourceId;

  @override
  Future<Result<int>> invoke(Json payload) async {
    return cockpitRepository.update(resourceId, payload).then((data) => data);
  }
}
