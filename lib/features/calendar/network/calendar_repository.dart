import 'package:app/core/cockpit_repository/cockpit_repository.dart';
import 'package:app/core/result/result.dart';
import 'package:app/extensions/result_extension.dart';
import 'package:app/features/calendar/models/event.dart';
import 'package:app/features/calendar/network/calendar_remote_data_source.dart';
import 'package:app/type_def/json.dart';

class CalendarRepository extends CockpitRepository {
  CalendarRepository({
    required this.remoteDS,
    this.title,
  });

  @override
  final String? title;

  @override
  final CalendarRemoteDataSource remoteDS;

  @override
  Future<Result<int>> create(Json payload) async {
    return remoteDS.create(payload).asResult<int>();
  }

  @override
  Future<void> delete(int resourceId) async {
    return remoteDS.delete(resourceId);
  }

  @override
  Future<Result<Event>> get(int resourceId) async {
    return remoteDS.get(resourceId).asResult<Event>(fromJson: Event.fromJson);
  }

  @override
  Future<Result<List<Event>>> getAll() async {
    return remoteDS.getAll().asListResult<Event>(fromJson: Event.fromJson);
  }

  @override
  Future<Result<int>> update(int resourceId, Json payload) {
    return remoteDS.update(resourceId, payload).asResult<int>();
  }
}
