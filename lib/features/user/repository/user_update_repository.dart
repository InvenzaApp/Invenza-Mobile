import 'package:app/extensions/result_extension.dart';
import 'package:app/features/user/repository/user_service.dart';
import 'package:app/type_def/json.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserUpdateRepository {
  UserUpdateRepository({
    required this.userService,
  });

  final UserService userService;

  Future<bool> updateUser(Json payload) async{
    final result = await userService.updateUser(payload).asResult<dynamic>();

    return result.isSuccess;
  }
}
