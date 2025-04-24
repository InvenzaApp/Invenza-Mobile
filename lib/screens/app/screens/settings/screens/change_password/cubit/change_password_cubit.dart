import 'package:app/features/user/repository/user_auth_repository.dart';
import 'package:app/screens/app/screens/settings/screens/change_password/cubit/change_password_state.dart';
import 'package:app/type_def/json.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({
    required this.repository,
  }) : super(const ChangePasswordState());

  final UserAuthRepository repository;

  Future<bool> changePassword(Json payload) async{
    emit(const ChangePasswordState(isLoading: true));
    final success = await repository.updatePassword(payload);
    emit(const ChangePasswordState(isLoading: false));

    return success;
  }
}
