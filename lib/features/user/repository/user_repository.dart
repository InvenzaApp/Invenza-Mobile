import 'package:app/core/result/result.dart';
import 'package:app/enums/api_messages.dart';
import 'package:app/extensions/result_extension.dart';
import 'package:app/features/organization/models/organization.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/features/user/models/user_auth_payload.dart';
import 'package:app/features/user/repository/user_service.dart';
import 'package:app/modules/secure_module.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserRepository {
  const UserRepository({
    required this.service,
  });

  final UserService service;
  static final secure = SecureModule();

  Future<Result<User>> signIn(UserAuthPayload payload) async {
    final response = await service.signIn(payload);
    final result = response.asResult<User>(User.fromJson);

    if (result.isSuccess) await secure.saveUserCredentials(payload);

    return result;
  }

  Future<Result<Organization>> getOrganization(int? organizationId) async {
    if (organizationId == null) {
      return ResultError(ApiMessages.invalidRequestParameters);
    }

    final response = await service.getOrganization(organizationId);
    return response.asResult<Organization>(Organization.fromJson);
  }
}
