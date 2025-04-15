import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

T inject<T extends Object>({
  Type? type,
  dynamic param1,
  dynamic param2,
  String? instanceName,
}) =>
    getIt.get<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
      type: type,
    );
