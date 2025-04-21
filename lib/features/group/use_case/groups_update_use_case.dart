import 'package:app/core/result/result.dart';
import 'package:app/core/use_case/use_case.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/features/group/network/groups_repository.dart';
import 'package:app/type_def/json.dart';

class GroupsUpdateUseCase extends UpdateUseCase {
  GroupsUpdateUseCase({
    required this.cockpitRepository,
    required this.resourceId,
    required this.userCubit,
  });

  @override
  final GroupsRepository cockpitRepository;

  @override
  final int resourceId;

  final UserCubit userCubit;

  @override
  Future<Result<int>> invoke(Json payload) async {
    final creatorId = userCubit.state.userResult!.maybeValue!.id;

    final mutablePayload = Map<String, dynamic>.from(payload);

    final existingUsers = (mutablePayload['usersIdList'] as List<int>?) ?? [];
    mutablePayload['usersIdList'] = [
      if (!existingUsers.contains(creatorId)) creatorId,
      ...existingUsers,
    ];

    return cockpitRepository.update(resourceId, mutablePayload);
  }
}
