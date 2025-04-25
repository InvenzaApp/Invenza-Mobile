import 'dart:convert';

import 'package:app/type_def/json.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class CockpitRemoteDataSource {
  CockpitRemoteDataSource({
    required this.httpClient,
    required this.baseUrl,
  });

  @protected
  final Dio httpClient;

  @protected
  final String baseUrl;

  Future<Response<Json>> create(Json payload) async{
    return httpClient.post<Json>(baseUrl, data: jsonEncode(payload));
  }

  Future<Response<Json>> getAll() async{
    return httpClient.get<Json>(baseUrl);
  }

  Future<Response<Json>> get(int resourceId) async{
    return httpClient.get<Json>('$baseUrl/$resourceId');
  }

  Future<void> delete(int resourceId) async{
    await httpClient.delete<Json>('$baseUrl/$resourceId');
  }

  Future<Response<Json>> update(int resourceId, Json payload) async{
    return httpClient.put<Json>('$baseUrl/$resourceId', data: jsonEncode(payload));
  }
}
