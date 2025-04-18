import 'package:app/cubit/token_cubit/token_cubit.dart';
import 'package:app/di.dart';
import 'package:app/interceptors/auth_interceptor.dart';
import 'package:app/interceptors/i_logger_interceptor.dart';
import 'package:app/interceptors/no_auth_interceptor.dart';
import 'package:dio/dio.dart';

void setupInterceptors() {
  inject<Dio>(instanceName: 'noAuthHttpClient').interceptors.addAll([
    NoAuthInterceptor(
      cubit: inject<TokenCubit>(),
    ),
    inject<ILoggerInterceptor>(),
  ]);

  inject<Dio>(instanceName: 'httpClient').interceptors.addAll([
    AuthInterceptor(
      cubit: inject<TokenCubit>(),
    ),
    inject<ILoggerInterceptor>(),
  ]);
}
