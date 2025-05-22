import 'package:app/core/result/result.dart';
import 'package:app/core/use_case/use_case.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/features/user/network/users_repository.dart';
import 'package:app/type_def/json.dart';

class UsersUpdateUseCase extends UpdateUseCase {
  UsersUpdateUseCase({
    required this.cockpitRepository,
    required this.userCubit,
    required this.resourceId,
  });

  @override
  final UsersRepository cockpitRepository;
  final UserCubit userCubit;

  @override
  final int resourceId;

  @override
  Future<Result<int>> invoke(Json payload) async {
    final selectedOrganizationId = userCubit.state.selectedOrganizationId!;
    final mutablePayload = Json.from(payload);

    final selectedOrganizations =
        (mutablePayload['organizationsIdList'] as List<int>?) ?? [];

    mutablePayload['organizationsIdList'] = [
      if (!selectedOrganizations.contains(selectedOrganizationId))...[
        selectedOrganizationId,
      ],
      ...selectedOrganizations,
    ];

    return cockpitRepository.update(resourceId, mutablePayload).then((data) => data);
  }
}
