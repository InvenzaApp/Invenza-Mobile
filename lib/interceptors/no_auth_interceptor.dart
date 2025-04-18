import 'dart:convert';

import 'package:app/cubit/token_cubit/token_cubit.dart';
import 'package:app/type_def/json.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class NoAuthInterceptor extends QueuedInterceptor {
  NoAuthInterceptor({required this.cubit});

  final TokenCubit cubit;

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final jsonData = jsonDecode(response.data as String) as Json;
    final token = jsonData['token'] as String?;

    if (token == null) return;

    cubit.token = token;

    super.onResponse(response, handler);
  }
}
