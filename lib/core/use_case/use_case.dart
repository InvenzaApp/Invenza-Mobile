import 'package:app/core/cockpit_repository/cockpit_repository.dart';
import 'package:app/core/result/result.dart';
import 'package:app/type_def/json.dart';

abstract class UseCase{
  Future<Result<int>> invoke(Json payload);

  CockpitRepository get cockpitRepository;
}

abstract class UpdateUseCase extends UseCase{
  @override
  Future<Result<int>> invoke(Json payload);

  @override
  CockpitRepository get cockpitRepository;

  int get resourceId;
}

abstract class CreateUseCase extends UseCase{
  @override
  Future<Result<int>> invoke(Json payload);

  @override
  CockpitRepository get cockpitRepository;
}
