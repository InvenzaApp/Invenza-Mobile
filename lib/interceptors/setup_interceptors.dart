import 'package:app/di.dart';
import 'package:app/interceptors/i_logger_interceptor.dart';
import 'package:dio/dio.dart';

void setupInterceptors(){
  inject<Dio>(instanceName: 'noAuthHttpClient').interceptors.addAll([
    inject<ILoggerInterceptor>(),
  ]);
}
