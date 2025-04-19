import 'package:app/features/user/models/user.dart';
import 'package:app/type_def/json.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization.g.dart';

@JsonSerializable(createToJson: false)
class Organization extends Equatable {
  const Organization({
    required this.id,
    required this.name,
    required this.usersList,
    required this.admin,
  });

  factory Organization.fromJson(Json json) => _$OrganizationFromJson(json);

  final int id;
  final String name;
  @JsonKey(name: 'users')
  final List<User> usersList;
  final User admin;

  @override
  List<Object?> get props => [id, name, usersList, admin];
}
