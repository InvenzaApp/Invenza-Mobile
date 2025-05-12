import 'package:app/core/entity/item_entity.dart';
import 'package:app/enums/task_status.dart';
import 'package:app/features/comment/models/comment.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/type_def/json.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable(createToJson: false)
class Task extends ItemEntity with EquatableMixin {
  Task({
    required this.id,
    required this.title,
    required this.groupsList,
    required this.createdAt,
    required this.groupsIdList,
    required this.status,
    required this.locked,
    required this.comments,
    required this.commentsEnabled,
    this.createdBy,
    this.description,
    this.deadline,
  });

  factory Task.fromJson(Json json) => _$TaskFromJson(json);

  @override
  final int id;
  @override
  final String title;
  final String? description;
  final DateTime? deadline;
  final List<Group>? groupsList;
  final List<int> groupsIdList;
  final DateTime createdAt;
  final User? createdBy;
  @JsonKey(fromJson: TaskStatus.fromJson, toJson: TaskStatus.toJson)
  final TaskStatus status;
  @override
  final bool locked;
  final List<Comment> comments;
  final bool commentsEnabled;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        deadline,
        groupsList,
        createdAt,
        createdBy,
        groupsIdList,
        status,
        locked,
        comments,
        commentsEnabled,
      ];
}
