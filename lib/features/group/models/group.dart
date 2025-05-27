import 'package:app/core/entity/item_entity.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/type_def/json.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable(createToJson: false)
class Group extends ItemEntity with EquatableMixin {
  Group({
    required this.id,
    required this.title,
    required this.locked,
    required this.organizationsIdList,
    this.usersList,
  });

  factory Group.fromJson(Json json) => _$GroupFromJson(json);

  @override
  final int id;
  @override
  final String title;
  final List<User>? usersList;
  final List<int> organizationsIdList;
  @override
  final bool locked;

  @override
  List<Object?> get props => [
        id,
        title,
        usersList,
        locked,
        organizationsIdList,
      ];
}
