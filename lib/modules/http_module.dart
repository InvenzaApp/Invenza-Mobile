import 'package:app/modules/ip_module.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class HttpModule{
    String get _baseUrl => IpModule.ipAddress();

    @singleton
    @Named('noAuthHttpClient')
    Dio get noAuthHttpClient => Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    @singleton
    @Named('httpClient')
    Dio get httpClient => Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
}
