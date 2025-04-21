import 'package:app/core/cockpit_repository/cockpit_repository.dart';
import 'package:app/core/result/result.dart';
import 'package:app/extensions/result_extension.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/features/user/network/users_remote_data_source.dart';
import 'package:app/type_def/json.dart';

class UsersRepository extends CockpitRepository {
  UsersRepository({
    required this.remoteDS,
    this.title,
  });

  @override
  final String? title;

  @override
  Future<Result<int>> create(Json payload) {
    return remoteDS.create(payload).asResult<int>();
  }

  @override
  Future<void> delete(int resourceId) async {
    await remoteDS.delete(resourceId);
  }

  @override
  Future<Result<User>> get(int resourceId) async {
    return remoteDS.get(resourceId).asResult<User>(fromJson: User.fromJson);
  }

  @override
  Future<Result<List<User>>> getAll() async {
    return remoteDS.getAll().asListResult<User>(fromJson: User.fromJson);
  }

  @override
  Future<Result<int>> update(int resourceId, Json payload) async {
    return remoteDS.update(resourceId, payload).asResult<int>();
  }

  @override
  final UsersRemoteDataSource remoteDS;
}
