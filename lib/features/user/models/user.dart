import 'package:app/core/entity/entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(createToJson: false)
class User extends Entity with EquatableMixin {
  User({
    required this.id,
    required this.name,
    required this.lastname,
    required this.title,
    required this.email,
    required this.organizationId,
    required this.groupsIdList,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  final int id;
  final String name;
  final String lastname;
  @override
  final String title;
  final String email;
  final int organizationId;
  final List<int> groupsIdList;

  @override
  List<Object?> get props => [
        id,
        name,
        lastname,
        title,
        email,
        organizationId,
        groupsIdList,
      ];
}
