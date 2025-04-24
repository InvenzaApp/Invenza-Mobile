import 'package:app/core/cockpit_repository/cockpit_repository.dart';
import 'package:app/core/result/result.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/result_extension.dart';
import 'package:app/features/permissions/network/permissions_remote_data_source.dart';
import 'package:app/type_def/json.dart';

class PermissionsRepository extends CockpitRepository {
  PermissionsRepository({
    required this.remoteDS,
  });

  @override
  Future<Result<int>> create(Json payload) {
    throw UnsupportedError("Permissions doesn't support create.");
  }

  @override
  Future<void> delete(int resourceId) {
    throw UnsupportedError("Permissions doesn't support delete.");
  }

  @override
  Future<Result<Object>> get(int resourceId) {
    throw UnsupportedError("Permissions doesn't support get.");
  }

  @override
  Future<Result<List<Permissions>>> getAll() async {
    return remoteDS
        .getAll()
        .asListResult<Permissions>(fromJson: Permissions.fromSingleJson);
  }

  @override
  Future<Result<int>> update(int resourceId, Json payload) {
    throw UnsupportedError("Permissions doesn't support update.");
  }

  @override
  final PermissionsRemoteDataSource remoteDS;
}
