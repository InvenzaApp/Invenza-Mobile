import 'package:app/features/comment/models/comment.dart';
import 'package:equatable/equatable.dart';

class CommentsState extends Equatable {
  const CommentsState({
    this.comments = const [],
    this.isLoading = false,
  });

  CommentsState copyWith({
    List<Comment>? comments,
    bool? isLoading,
}){
    return CommentsState(
      comments: comments ?? this.comments,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final List<Comment> comments;
  final bool isLoading;

  @override
  List<Object?> get props => [comments, isLoading];
}
