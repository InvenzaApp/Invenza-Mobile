import 'dart:convert';

import 'package:app/cubit/token_cubit/token_cubit.dart';
import 'package:app/type_def/json.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({required this.cubit});

  final TokenCubit cubit;

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    late Json jsonData;
    if(response.data is Json){
      jsonData = response.data as Json;
    }else{
      jsonData = jsonDecode(response.data as String) as Json;
    }

    final token = jsonData['token'] as String?;

    if (token != null) {
      cubit.token = token;
    }

    super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['authorization'] = 'Bearer ${cubit.token}';
    super.onRequest(options, handler);
  }
}
