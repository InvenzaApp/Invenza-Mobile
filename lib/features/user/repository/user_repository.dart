import 'package:app/enums/api_messages.dart';
import 'package:app/features/organization/models/organization.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/features/user/models/user_auth_payload.dart';
import 'package:app/features/user/repository/user_service.dart';
import 'package:app/modules/secure_module.dart';
import 'package:app/type_def/json.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserRepository {
  const UserRepository({
    required this.service,
  });

  final UserService service;
  static final secure = SecureModule();

  Future<Result<User>> signIn(UserAuthPayload payload) async {
    return service.signIn(payload).asResult<User>(User.fromJson);
  }

  Future<Organization?> getOrganization(int? organizationId) async {
    if (organizationId == null) return null;

    return service.getOrganization(organizationId).then(Organization.fromJson);
  }
}

extension ResultExtension<T> on Future<Json>{
  Result<E> asResult<E>(T Function(Json) fromJson){
    return Result();
  }
}

class Result<T> {
  Result({
    this.data,
    this.error,
  });

  final T? data;
  final ApiMessages? error;

  bool get isSuccess => data != null;

  bool get isError => error != null;
}
