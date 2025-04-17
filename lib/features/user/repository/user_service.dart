import 'dart:convert';

import 'package:app/features/user/models/user_auth_payload.dart';
import 'package:app/type_def/json.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserService {
  UserService({
    @Named('noAuthHttpClient') required Dio dio,
  }) : _dio = dio;
  final Dio _dio;

  static const userUrl = '/api/user';
  static const organizationUrl = '/api/organization';

  Future<Json> signIn(UserAuthPayload payload) async {
    return _dio
        .post<String>('$userUrl/sign-in', data: payload.toJson())
        .then((res) => jsonDecode(res.data!)['data'] as Json)
        .catchError((e) => noInternetConnectionJson);
  }

  Future<Json> getOrganization(int organizationId) async {
    return _dio
        .get<String>('$organizationUrl/$organizationId')
        .then((res) => jsonDecode(res.data!)['data'] as Json)
        .catchError((e) => noInternetConnectionJson);
  }
}
