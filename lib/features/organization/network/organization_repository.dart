import 'package:app/extensions/result_extension.dart';
import 'package:app/features/user/repository/user_service.dart';
import 'package:app/type_def/json.dart';
import 'package:injectable/injectable.dart';

@singleton
class OrganizationRepository {
  OrganizationRepository({
    required this.service,
  });

  final UserService service;

  Future<bool> updateOrganization(Json payload) async{
    final success = await service.updateOrganization(payload).asResult<bool>();
    return success.isSuccess;
  }
}
