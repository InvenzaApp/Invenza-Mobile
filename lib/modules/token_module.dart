import 'package:app/type_def/json.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

@injectable
class TokenModule {
  TokenModule({
    @Named('httpClient') required Dio dio,
  }) : _httpClient = dio;

  final Dio _httpClient;

  Future<void> registerToken({required String email}) async {
    final token = await FirebaseMessaging.instance.getToken();

    if (token == null) return;

    await _httpClient.post<Json>('/api/token', data: {'token': token});
  }
}
