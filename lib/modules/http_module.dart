import 'package:app/modules/ip_module.dart';
import 'package:app/modules/storage_module.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class HttpModule{
    String get _baseUrl => IpModule.ipAddress();
    final storage = StorageModule();

    @singleton
    @Named('noAuthHttpClient')
    Dio get noAuthHttpClient => _createDio();

    @singleton
    @Named('httpClient')
    Dio get httpClient => _createDio();

    Dio _createDio() {
      final dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      return dio;
    }
}
