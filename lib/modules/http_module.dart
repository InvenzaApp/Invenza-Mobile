import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class HttpModule{
    String get _baseUrl => 'http://10.0.2.2:8080';

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
