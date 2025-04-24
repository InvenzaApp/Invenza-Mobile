import 'package:app/core/entity/entity.dart';
import 'package:app/enums/task_status.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/type_def/json.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable(createToJson: false)
class Task extends Entity with EquatableMixin {
  Task({
    required this.id,
    required this.title,
    required this.groupsList,
    required this.createdAt,
    required this.createdBy,
    required this.groupsIdList,
    required this.status,
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
  final User createdBy;
  @JsonKey(fromJson: TaskStatus.fromJson, toJson: TaskStatus.toJson)
  final TaskStatus status;

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
      ];
}
