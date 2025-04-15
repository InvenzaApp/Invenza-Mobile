import 'package:app/core/result/result.dart';
import 'package:app/cubit/user_cubit/user_state.dart';
import 'package:app/models/user/user_auth_payload.dart';
import 'package:app/modules/secure_module.dart';
import 'package:app/network/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserCubit extends Cubit<UserState> {
  UserCubit({
    required this.repo,
  }) : super(UserState(result: EmptyResult()));

  final UserRepository repo;
  static final secure = SecureModule();

  Future<void> signIn(UserAuthPayload payload) async{
    emit(state.copyWith(isLoading: true));

    final result = await repo.signIn(payload);

    emit(state.copyWith(isLoading: false, result: result));
  }

  Future<void> signInWithSavedCredentials() async{
    final payload = await secure.getUserCredentials();

    if(payload == null) return;

    await signIn(payload);
  }

  Future<void> signOut() async{
    await secure.deleteUserCredentials();
  }
}
