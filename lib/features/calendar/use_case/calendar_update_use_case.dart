import 'package:app/core/result/result.dart';
import 'package:app/core/use_case/use_case.dart';
import 'package:app/features/calendar/network/calendar_repository.dart';
import 'package:app/type_def/json.dart';

class CalendarUpdateUseCase extends UpdateUseCase {
  CalendarUpdateUseCase({
    required this.resourceId,
    required this.cockpitRepository,
  });

  @override
  final int resourceId;

  @override
  final CalendarRepository cockpitRepository;

  @override
  Future<Result<int>> invoke(Json payload) {
    return cockpitRepository.update(resourceId, payload).then((data) => data);
  }
}
