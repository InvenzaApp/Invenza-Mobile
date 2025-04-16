import 'package:app/core/cockpit_repository/cockpit_repository.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/features/group/network/groups_remote_data_source.dart';
import 'package:app/type_def/json.dart';

class GroupsRepository extends CockpitRepository {
  GroupsRepository({
    required this.remoteDS,
  });

  @override
  Future<int> create(Json payload) async {
    return remoteDS.create(payload).then((data) => data);
  }

  @override
  Future<void> delete(int resourceId) async {
    await remoteDS.delete(resourceId);
  }

  @override
  Future<Group> get(int resourceId) {
    return remoteDS
        .get(resourceId)
        .then((data) => Group.fromJson(data as Json));
  }

  @override
  Future<List<Group>> getAll() {
    return remoteDS.getAll().then(
          (data) => data.map((item) => Group.fromJson(item as Json)).toList(),
        );
  }

  @override
  final GroupsRemoteDataSource remoteDS;

  @override
  Future<int> update(int resourceId, Json payload) {
    return remoteDS.update(resourceId, payload).then((data) => data);
  }
}
