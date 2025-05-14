import 'package:app/core/result/result.dart';
import 'package:app/core/use_case/use_case.dart';
import 'package:app/features/calendar/network/calendar_repository.dart';
import 'package:app/type_def/json.dart';

class CalendarCreateUseCase extends CreateUseCase {
  CalendarCreateUseCase({
    required this.cockpitRepository,
  });

  @override
  final CalendarRepository cockpitRepository;

  @override
  Future<Result<int>> invoke(Json payload) {
    return cockpitRepository.create(payload).then((data) => data);
  }
}
