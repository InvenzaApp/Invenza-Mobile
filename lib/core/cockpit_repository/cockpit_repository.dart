import 'package:app/core/cockpit_repository/cockpit_remote_data_source.dart';
import 'package:app/core/result/result.dart';
import 'package:app/type_def/json.dart';

abstract class CockpitRepository{
  String? get title => null;

  CockpitRemoteDataSource get remoteDS;

  Future<Result<int>> create(Json payload);

  Future<Result<List<Object>>> getAll();

  Future<Result<Object>> get(int resourceId);

  Future<void> delete(int resourceId);

  Future<Result<int>> update(int resourceId, Json payload);
}
