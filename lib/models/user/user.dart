import 'package:app/models/organization.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(createToJson: false)
class User extends Equatable {
  const User({
    required this.name,
    required this.lastname,
    required this.email,
    required this.organization,
    required this.groupsIdList,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final String name;
  final String lastname;
  final String email;
  final Organization organization;
  final List<int> groupsIdList;

  @override
  List<Object?> get props => [
        name,
        lastname,
        email,
        organization,
        groupsIdList,
      ];
}
