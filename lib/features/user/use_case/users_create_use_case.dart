import 'package:app/core/result/result.dart';
import 'package:app/core/use_case/use_case.dart';
import 'package:app/features/user/network/users_repository.dart';
import 'package:app/type_def/json.dart';

class UsersCreateUseCase extends CreateUseCase {
  UsersCreateUseCase({
    required this.cockpitRepository,
  });

  @override
  final UsersRepository cockpitRepository;

  @override
  Future<Result<int>> invoke(Json payload) async {
    return cockpitRepository.create(payload).then((data) => data);
  }
}
