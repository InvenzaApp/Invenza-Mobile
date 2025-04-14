import 'package:app/cubit/user_cubit/user_state.dart';
import 'package:app/models/user/user_auth_payload.dart';
import 'package:app/network/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required this.repo,
  }) : super(const UserState());

  Future<bool> signIn(UserAuthPayload payload) async{
    emit(state.copyWith(isLoading: true));

    final result = await repo.signIn(payload);

    if(result.isSuccess()){
      emit(state.copyWith(user: result.maybeValue!.data));
    }

    emit(state.copyWith(isLoading: false));
    return result.isSuccess();
  }

  final UserRepository repo;
}
