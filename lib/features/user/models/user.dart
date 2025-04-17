import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(createToJson: false)
class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.lastname,
    required this.email,
    required this.organizationId,
    required this.groupsIdList,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String name;
  final String lastname;
  final String email;
  final int organizationId;
  final List<int> groupsIdList;

  @override
  List<Object?> get props => [
        id,
        name,
        lastname,
        email,
        organizationId,
        groupsIdList,
      ];
}
