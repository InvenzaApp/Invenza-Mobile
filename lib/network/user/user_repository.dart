import 'package:app/core/result/result.dart';
import 'package:app/extensions/result_extension.dart';
import 'package:app/models/user/user.dart';
import 'package:app/models/user/user_auth_payload.dart';
import 'package:app/modules/secure_module.dart';
import 'package:app/network/user/user_service.dart';
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

    if(result.isSuccess) await secure.saveUserCredentials(payload);

    return result;
  }
}
