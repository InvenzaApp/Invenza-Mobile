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

  Future<bool> create(Json payload) async{
    return httpClient.post<Json>(baseUrl, data: jsonEncode(payload))
        .then((res) => res.data)
        .then((data) => data!['success'] == true);
  }
}
