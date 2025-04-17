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

  Future<int> create(Json payload) async{
    return httpClient.post<Json>(baseUrl, data: jsonEncode(payload))
        .then((res) => res.data)
        .then((data) => data!['data'] as int);
  }

  Future<List<dynamic>> getAll() async{
    return httpClient.get<Json>(baseUrl)
        .then((res) => res.data)
        .then((data) => data!['data'] as List<dynamic>);
  }

  Future<dynamic> get(int resourceId) async{
    return httpClient.get<Json>('$baseUrl/$resourceId')
        .then((res) => res.data)
        .then((data) => data!['data']);
  }

  Future<void> delete(int resourceId) async{
    await httpClient.delete<Json>('$baseUrl/$resourceId');
  }

  Future<int> update(int resourceId, Json payload) async{
    return httpClient.put<Json>('$baseUrl/$resourceId', data: jsonEncode(payload))
        .then((res) => res.data)
        .then((data) => data!['data'] as int);
  }
}
