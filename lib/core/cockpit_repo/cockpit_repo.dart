import 'package:app/core/cockpit_repo/cockpit_remote_data_source.dart';
import 'package:app/type_def/json.dart';

abstract class CockpitRepo{
  String get title;

  String get baseUrl;

  CockpitRemoteDataSource get remoteDS;

  UseCase get useCase;

  Future<void> create(Json payload);
}

abstract class UseCase{
  Future<void> invoke(Json payload);
}

abstract class UpdateUseCase extends UseCase{
  @override
  Future<void> invoke(Json payload);
}

abstract class CreateUseCase extends UseCase{
  @override
  Future<void> invoke(Json payload);
}
