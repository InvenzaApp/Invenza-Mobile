import 'package:app/core/result/result.dart';
import 'package:app/extensions/result_extension.dart';
import 'package:app/features/comment/models/comment.dart';
import 'package:app/features/comment/network/comments_remote_data_source.dart';
import 'package:app/type_def/json.dart';
import 'package:injectable/injectable.dart';

@singleton
class CommentsRepository {
  CommentsRepository({
    required this.remoteDS,
  });

  final CommentsRemoteDataSource remoteDS;

  Future<Result<List<Comment>>> fetchComments({required int taskId}) async {
    return remoteDS
        .fetchComments(taskId: taskId)
        .asListResult<Comment>(fromJson: Comment.fromJson);
  }

  Future<Result<bool>> postComment(Json payload) async {
    return remoteDS.postComment(payload).asResult<bool>();
  }

  Future<Result<bool>> deleteComment(int commentId, int taskId) async{
    return remoteDS.deleteComment(commentId, taskId).asResult<bool>();
  }
}
