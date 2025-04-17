import 'package:app/core/cockpit_repository/cockpit_remote_data_source.dart';
import 'package:app/type_def/json.dart';

abstract class CockpitRepository{
  String? get title => null;

  CockpitRemoteDataSource get remoteDS;

  Future<int> create(Json payload);

  Future<List<Object>> getAll();

  Future<Object> get(int resourceId);

  Future<void> delete(int resourceId);

  Future<int> update(int resourceId, Json payload);
}
