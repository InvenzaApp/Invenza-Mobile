import 'dart:convert';

import 'package:app/features/user/models/user_auth_payload.dart';
import 'package:app/type_def/json.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserService {
  UserService({
    @Named('noAuthHttpClient') required Dio noAuthDio,
    @Named('httpClient') required Dio authDio,
  })  : _noAuthDio = noAuthDio,
        _authDio = authDio;

  final Dio _noAuthDio;
  final Dio _authDio;

  static const userUrl = '/api/users';
  static const organizationUrl = '/api/organization';

  Future<Json> signIn(UserAuthPayload payload) async {
    return _noAuthDio
        .post<String>('$userUrl/sign-in', data: payload.toJson())
        .then((res) => jsonDecode(res.data!) as Json)
        .catchError((e) => noInternetConnectionJson);
  }

  Future<Json> getOrganization(int organizationId) async {
    return _authDio
        .get<String>('$organizationUrl/$organizationId')
        .then((res) => jsonDecode(res.data!) as Json)
        .catchError((e) => noInternetConnectionJson);
  }

  Future<Json> selectOrganization(int organizationId) async {
    return _authDio
        .post<String>(
          '$organizationUrl/select-organization',
          data: {
            'organizationId': organizationId,
          },
        )
        .then((res) => jsonDecode(res.data!) as Json)
        .catchError((e) => noInternetConnectionJson);
  }

  Future<Json> getOrganizations() async {
    return _authDio
        .get<String>('$organizationUrl/')
        .then((res) => jsonDecode(res.data!) as Json)
        .catchError((e) => noInternetConnectionJson);
  }

  Future<Json> changePassword(Json payload) async {
    return _authDio
        .post<String>('$userUrl/update-password', data: payload)
        .then((res) => jsonDecode(res.data!) as Json)
        .catchError((e) => noInternetConnectionJson);
  }

  Future<Json> updateUser(Json payload) async {
    return _authDio
        .post<String>('$userUrl/update-user', data: payload)
        .then((res) => jsonDecode(res.data!) as Json)
        .catchError((e) => noInternetConnectionJson);
  }

  Future<Json> updateOrganization(Json payload) async {
    return _authDio
        .post<String>('$organizationUrl/organization-update', data: payload)
        .then((res) => jsonDecode(res.data!) as Json)
        .catchError((e) => noInternetConnectionJson);
  }

  Future<Json> fetchUser(int userId) async {
    return _authDio
        .get<String>('$userUrl/get-user/$userId')
        .then((res) => jsonDecode(res.data!) as Json)
        .catchError((e) => noInternetConnectionJson);
  }
}
