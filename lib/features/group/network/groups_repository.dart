import 'package:app/core/cockpit_repository/cockpit_repository.dart';
import 'package:app/core/result/result.dart';
import 'package:app/extensions/result_extension.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/features/group/network/groups_remote_data_source.dart';
import 'package:app/type_def/json.dart';

class GroupsRepository extends CockpitRepository {
  GroupsRepository({
    required this.remoteDS,
    this.title,
  });

  @override
  final String? title;

  @override
  Future<Result<int>> create(Json payload) async {
    return remoteDS.create(payload).asResult<int>();
  }

  @override
  Future<void> delete(int resourceId) async {
    await remoteDS.delete(resourceId);
  }

  @override
  Future<Result<Group>> get(int resourceId) {
    return remoteDS.get(resourceId).asResult<Group>(fromJson: Group.fromJson);
  }

  @override
  Future<Result<List<Group>>> getAll() {
    return remoteDS.getAll().asListResult<Group>(fromJson: Group.fromJson);
  }

  @override
  final GroupsRemoteDataSource remoteDS;

  @override
  Future<Result<int>> update(int resourceId, Json payload) {
    return remoteDS.update(resourceId, payload).asResult<int>();
  }
}
