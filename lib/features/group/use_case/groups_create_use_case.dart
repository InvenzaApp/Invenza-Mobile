import 'package:app/core/result/result.dart';
import 'package:app/core/use_case/use_case.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/features/group/network/groups_repository.dart';
import 'package:app/type_def/json.dart';

class GroupsCreateUseCase extends CreateUseCase {
  GroupsCreateUseCase({
    required this.cockpitRepository,
    required this.userCubit,
  });

  @override
  final GroupsRepository cockpitRepository;
  final UserCubit userCubit;

  @override
  Future<Result<int>> invoke(Json payload) async {
    final creatorId = userCubit.state.userResult!.maybeValue!.id;
    final defaultOrganizationId = userCubit.state.selectedOrganizationId!;

    final mutablePayload = Json.from(payload);

    final existingUsers = (mutablePayload['usersIdList'] as List<int>?) ?? [];
    mutablePayload['usersIdList'] = [creatorId, ...existingUsers];

    final selectedOrganizations =
        (mutablePayload['organizationsIdList'] as List<int>?) ?? [];

    mutablePayload['organizationsIdList'] = [
      defaultOrganizationId,
      ...selectedOrganizations,
    ];

    return cockpitRepository.create(mutablePayload);
  }
}
