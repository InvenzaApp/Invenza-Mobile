import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/di.dart';
import 'package:app/enums/permissions.dart';

class UserPermissions{
  static bool hasPermission(Permissions permission){
    final cubit = inject<UserCubit>();
    final user = cubit.state.userResult!.maybeValue!;

    return user.permissions.contains(permission);
  }
}
