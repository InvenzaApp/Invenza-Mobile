import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/core/list/cubit/list_cubit.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/features/user/network/users_repository.dart';

class UsersListCubit extends ListCubit<User> {
  UsersListCubit({
    required this.repository,
  }) : super(createRoute: const UsersCreateFormRoute());

  @override
  final UsersRepository repository;

  @override
  Future<void> initialize() async {
    await fetch();
  }

  Future<void> fetch() async{
    super.emitState(isLoading: true);
    final result = await repository.getAll();
    super.emitState(isLoading: false, data: result);
  }
}
