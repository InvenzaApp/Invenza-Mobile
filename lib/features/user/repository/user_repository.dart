import 'package:app/core/result/result.dart';
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
    return service.signIn(payload).asResult<User>(fromJson: User.fromJson);
  }

  Future<Result<Organization>> getOrganization(int organizationId) async {
    return service
        .getOrganization(organizationId)
        .asResult<Organization>(fromJson: Organization.fromJson);
  }
}
