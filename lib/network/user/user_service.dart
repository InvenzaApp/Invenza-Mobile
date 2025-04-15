import 'dart:convert';

import 'package:app/models/user/user_auth_payload.dart';
import 'package:app/type_def/json.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserService {
  UserService({
    @Named('noAuthHttpClient') required Dio dio,
  }) : _dio = dio;
  final Dio _dio;

  static const baseUrl = '/api/user';

  Future<Json> signIn(UserAuthPayload payload) async {
    return _dio
        .post<String>('$baseUrl/sign-in', data: payload.toJson())
        .then((res) => jsonDecode(res.data!) as Json);
  }
}
