import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@singleton
class ILoggerInterceptor extends QueuedInterceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('********** REQUEST **********');
    debugPrint('URI: ${options.uri}');
    debugPrint('DATA: ${options.data}');
    debugPrint('HEADERS: ${options.headers}');
    debugPrint('METHOD: ${options.method}');
    debugPrint('PATH: ${options.path}');
    debugPrint('QUERY PARAMETERS: ${options.queryParameters}');
    debugPrint('******************************\n');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    debugPrint('********** RESPONSE **********');
    debugPrint('URI: ${response.requestOptions.uri}');
    debugPrint('DATA: ${response.data}');
    debugPrint('STATUS CODE: ${response.statusCode}');
    debugPrint('STATUS MESSAGE: ${response.statusMessage}');
    debugPrint('******************************\n');
    super.onResponse(response, handler);
  }
}
