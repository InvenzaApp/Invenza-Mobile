import 'package:app/cubit/user_cubit/user_state.dart';
import 'package:app/features/user/models/user_auth_payload.dart';
import 'package:app/features/user/repository/user_repository.dart';
import 'package:app/modules/secure_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserCubit extends Cubit<UserState> {
  UserCubit({
    required this.repo,
  }) : super(const UserState());

  final UserRepository repo;
  static final secure = SecureModule();

  void reset() => emit(const UserState());

  Future<void> signIn(UserAuthPayload payload) async {
    emit(state.copyWith(isLoading: true));

    final user = await repo.signIn(payload);

    emit(
      state.copyWith(
        isLoading: false,
        user: user,
      ),
    );
  }

  Future<void> fetchOrganization() async {
    final organization =
        await repo.getOrganization(state.user!.organizationId);

    emit(state.copyWith(organization: organization));
  }

  Future<void> signInWithSavedCredentials() async {
    final payload = await secure.getUserCredentials();

    if (payload == null) return;

    await signIn(payload);
  }

  Future<void> signOut() async {
    await secure.deleteUserCredentials();
    reset();
  }
}
