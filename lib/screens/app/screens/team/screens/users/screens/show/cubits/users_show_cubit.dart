import 'package:app/core/show/cubit/show_cubit.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/features/user/network/users_repository.dart';

class UsersShowCubit extends ShowCubit<User>{
  UsersShowCubit({
    required this.repository,
    required this.resourceId,
}) : super();

  @override
  final UsersRepository repository;

  @override
  final int resourceId;

  @override
  Future<void> delete() async {
    await repository.delete(resourceId);
  }

  @override
  Future<void> initialize() async {
    await fetch();
  }

  Future<void> fetch() async{
    super.emitState(isLoading: true);
    final result = await repository.get(resourceId);
    super.emitState(isLoading: false, data: result);
  }
}
