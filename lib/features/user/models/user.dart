import 'package:app/core/entity/item_entity.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/features/group/models/group.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(createToJson: false)
class User extends ItemEntity with EquatableMixin {
  User({
    required this.id,
    required this.name,
    required this.lastname,
    required this.title,
    required this.email,
    required this.organizationsIdList,
    required this.groupsIdList,
    required this.permissions,
    required this.admin,
    required this.superadmin,
    required this.locked,
    this.groups,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  final int id;
  final String name;
  final String lastname;
  @override
  final String title;
  final String email;
  final List<int> organizationsIdList;
  final List<int> groupsIdList;
  @JsonKey(fromJson: Permissions.fromJson, toJson: Permissions.toJson)
  final List<Permissions> permissions;
  final List<Group>? groups;
  final bool admin;
  final bool superadmin;
  @override
  final bool locked;

  @override
  List<Object?> get props => [
        id,
        name,
        lastname,
        title,
        email,
        organizationsIdList,
        groupsIdList,
        permissions,
        groups,
        locked,
      ];
}
