import 'package:app/cubit/user_cubit/user_state.dart';
import 'package:app/di.dart';
import 'package:app/features/organization/network/organization_repository.dart';
import 'package:app/features/user/models/user_auth_payload.dart';
import 'package:app/features/user/repository/user_auth_repository.dart';
import 'package:app/modules/secure_module.dart';
import 'package:app/modules/token_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserCubit extends Cubit<UserState> {
  UserCubit({
    required this.repo,
    required this.tokenModule,
  }) : super(const UserState());

  final UserAuthRepository repo;
  final organizationRepository = inject<OrganizationRepository>();
  final TokenModule tokenModule;
  static final secure = SecureModule();

  void reset() => emit(const UserState());

  Future<void> signIn(UserAuthPayload payload) async {
    emit(state.copyWith(isLoading: true));

    if (state.userResult != null) return;

    final result = await repo.signIn(payload);

    emit(
      state.copyWith(
        userResult: result,
        isLoading: false,
      ),
    );

    if (result.isSuccess) {
      await secure.saveUserCredentials(payload);
      await tokenModule.registerToken(email: payload.email);
      await _checkSavedOrganization();
    }
  }

  Future<void> _checkSavedOrganization() async {
    final organizationId = await secure.getOrganizationId();

    if (organizationId == null) return;

    await fetchOrganizations();

    await selectOrganization(organizationId);
  }

  Future<void> fetchOrganizations() async {
    emit(state.copyWith(isFetchingOrganizations: true));

    final result = await organizationRepository.getAll();

    emit(
      state.copyWith(
        isFetchingOrganizations: false,
        organizationsList: result.isSuccess ? result.maybeValue! : null,
      ),
    );
  }

  void unselectOrganization() =>
      emit(state.copyWith(selectedOrganizationId: null));

  Future<void> selectOrganization(int organizationId) async {
    emit(state.copyWith(isLoading: true));

    final result =
        await organizationRepository.selectOrganization(organizationId);

    if (result.isError) return;

    await secure.saveOrganizationId(organizationId);

    emit(state.copyWith(selectedOrganizationId: organizationId));

    await fetchOrganization();
  }

  Future<void> fetchOrganization() async {
    emit(state.copyWith(isLoading: true));

    if (state.selectedOrganizationId == null) {
      emit(state.copyWith(isLoading: false));
      return;
    }

    if (state.userResult?.isError ?? false) {
      emit(state.copyWith(isLoading: false));
      return;
    }

    final result =
        await organizationRepository.get(state.selectedOrganizationId!);

    emit(state.copyWith(organizationResult: result, isLoading: false));
  }

  Future<void> fetchUser() async {
    if (state.userResult?.isError ?? true) return;
    emit(state.copyWith(isLoading: true));
    final newUserResult =
        await repo.fetchUser(state.userResult!.maybeValue!.id);
    emit(state.copyWith(isLoading: false, userResult: newUserResult));
  }

  Future<void> signInWithSavedCredentials() async {
    final payload = await secure.getUserCredentials();

    if (payload == null) return;

    await signIn(payload);
  }

  Future<void> signOut() async {
    await secure.deleteUserCredentials();
    await secure.deleteOrganization();
    reset();
  }
}
