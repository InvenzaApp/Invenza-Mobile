import 'package:app/core/result/result.dart';
import 'package:app/core/use_case/use_case.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/features/user/network/users_repository.dart';
import 'package:app/type_def/json.dart';

class UsersCreateUseCase extends CreateUseCase {
  UsersCreateUseCase({
    required this.cockpitRepository,
    required this.userCubit,
  });

  @override
  final UsersRepository cockpitRepository;
  final UserCubit userCubit;

  @override
  Future<Result<int>> invoke(Json payload) async {
    final selectedOrganizationId = userCubit.state.selectedOrganizationId!;
    final mutablePayload = Json.from(payload);

    final selectedOrganizations = (mutablePayload['organizationsIdList'] as List<int>?) ?? [];
    mutablePayload['organizationsIdList'] = [selectedOrganizationId, ...selectedOrganizations];

    return cockpitRepository.create(mutablePayload).then((data) => data);
  }
}
