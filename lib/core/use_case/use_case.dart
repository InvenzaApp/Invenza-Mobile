import 'package:app/core/cockpit_repository/cockpit_repository.dart';
import 'package:app/type_def/json.dart';

abstract class UseCase{
  Future<int> invoke(Json payload);

  CockpitRepository get cockpitRepository;
}

abstract class UpdateUseCase extends UseCase{
  @override
  Future<int> invoke(Json payload);

  @override
  CockpitRepository get cockpitRepository;

  int get resourceId;
}

abstract class CreateUseCase extends UseCase{
  @override
  Future<int> invoke(Json payload);

  @override
  CockpitRepository get cockpitRepository;
}
