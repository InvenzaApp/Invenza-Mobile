import 'package:app/core/result/result.dart';
import 'package:app/core/use_case/use_case.dart';
import 'package:app/features/organization/network/organization_repository.dart';
import 'package:app/type_def/json.dart';

class OrganizationCreateUseCase extends CreateUseCase {
  OrganizationCreateUseCase({
    required this.cockpitRepository,
  });

  @override
  final OrganizationRepository cockpitRepository;

  @override
  Future<Result<int>> invoke(Json payload) async {
    return cockpitRepository.create(payload);
  }
}
