import 'package:app/type_def/json.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable(createToJson: false)
class Group extends Equatable {
  const Group({
    required this.id,
    required this.name,
    required this.usersIdList,
  });

  factory Group.fromJson(Json json) => _$GroupFromJson(json);

  final int id;
  final String name;
  final List<int> usersIdList;

  @override
  List<Object?> get props => [];
}
