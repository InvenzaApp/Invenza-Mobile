import 'package:app/type_def/json.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable(createToJson: false)
class Task extends Equatable {
  const Task({
    required this.id,
    required this.title,
    required this.groupsIdList,
    this.description,
    this.deadline,
  });

  factory Task.fromJson(Json json) => _$TaskFromJson(json);

  final int id;
  final String title;
  final String? description;
  final DateTime? deadline;
  final List<int> groupsIdList;

  @override
  List<Object?> get props => [id, title, description, deadline, groupsIdList];
}
