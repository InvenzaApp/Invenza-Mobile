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

  Future<User> signIn(UserAuthPayload payload) async {
    return service.signIn(payload).then(User.fromJson);
  }

  Future<Organization?> getOrganization(int? organizationId) async {
    if (organizationId == null) return null;

    return service
        .getOrganization(organizationId)
        .then(Organization.fromJson);
  }
}
