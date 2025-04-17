import 'package:app/core/cockpit_repository/cockpit_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@singleton
class TasksRemoteDataSource extends CockpitRemoteDataSource {
  TasksRemoteDataSource({
    @Named('noAuthHttpClient') required super.httpClient,
  }) : super(baseUrl: '/api/tasks');
}
