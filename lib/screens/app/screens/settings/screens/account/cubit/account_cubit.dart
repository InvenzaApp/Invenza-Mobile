import 'package:app/features/user/repository/user_update_repository.dart';
import 'package:app/screens/app/screens/settings/screens/account/cubit/account_state.dart';
import 'package:app/type_def/json.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit({
    required this.repository,
  }) : super(const AccountState());

  final UserUpdateRepository repository;

  Future<bool> updateUser(Json payload) async {
    emit(const AccountState(isLoading: true));
    final success = await repository.updateUser(payload);
    emit(const AccountState(isLoading: false));
    return success;
  }
}
