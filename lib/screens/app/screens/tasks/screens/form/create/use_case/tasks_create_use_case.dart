import 'package:app/core/cockpit_repo/cockpit_repo.dart';
import 'package:app/type_def/json.dart';
import 'package:injectable/injectable.dart';

@singleton
class TasksCreateUseCase extends CreateUseCase{
  @override
  Future<void> invoke(Json payload) async{
    print(payload);
  }
}
