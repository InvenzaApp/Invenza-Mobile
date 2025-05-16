import 'package:app/core/cockpit_repository/cockpit_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@singleton
class CalendarRemoteDataSource extends CockpitRemoteDataSource {
  CalendarRemoteDataSource({
    @Named('httpClient') required super.httpClient,
  }) : super(baseUrl: '/api/calendar');
}
