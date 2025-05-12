import 'package:app/features/comment/network/comments_repository.dart';
import 'package:app/screens/app/screens/tasks/screens/comments/cubit/comments_state.dart';
import 'package:app/type_def/json.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit({
    required this.repository,
    required this.taskId,
  }) : super(const CommentsState()) {
    initialize();
  }

  final CommentsRepository repository;
  final int taskId;

  Future<void> initialize() async {
    await fetchComments();
  }

  Future<void> fetchComments() async {
    emit(state.copyWith(isLoading: true));
    final result = await repository.fetchComments(taskId: taskId);
    emit(
      state.copyWith(
        isLoading: false,
        comments: result.isSuccess ? result.maybeValue! : [],
      ),
    );
  }

  Future<bool> postComment(Json payload) async {
    final result = await repository.postComment(payload);

    return result.isSuccess;
  }

  Future<bool> deleteComment(int commentId) async{
    final result = await repository.deleteComment(commentId, taskId);
    return result.isSuccess;
  }
}
