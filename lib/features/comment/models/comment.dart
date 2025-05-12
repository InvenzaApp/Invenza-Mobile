import 'package:app/core/entity/entity.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/type_def/json.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable(createToJson: false)
class Comment extends Entity with EquatableMixin {
  Comment({
    required this.id,
    required this.title,
    required this.publishDate,
    required this.deleted,
    this.author,
  });

  factory Comment.fromJson(Json json) => _$CommentFromJson(json);

  @override
  final int id;
  final User? author;
  @override
  final String title;
  final DateTime publishDate;
  final bool deleted;

  @override
  List<Object?> get props => [id, author, title, publishDate, deleted];
}
