import 'package:app/type_def/json.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class CommentsRemoteDataSource {
  CommentsRemoteDataSource({
    @Named('httpClient') required Dio dio,
  }) : _httpClient = dio;

  final Dio _httpClient;
  static const baseUrl = '/api/comments';

  Future<Response<Json>> fetchComments({required int taskId}) async {
    return _httpClient.get<Json>('$baseUrl/', data: {'taskId': taskId});
  }

  Future<Response<Json>> postComment(Json payload) async {
    return _httpClient.post<Json>('$baseUrl/', data: payload);
  }

  Future<Response<Json>> deleteComment(int commentId, int taskId) async {
    return _httpClient
        .delete<Json>('$baseUrl/$commentId', data: {'taskId': taskId});
  }
}
