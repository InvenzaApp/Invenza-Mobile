import 'package:app/core/entity/entity.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/type_def/json.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization.g.dart';

@JsonSerializable(createToJson: false)
class Organization extends Entity with EquatableMixin {
  Organization({
    required this.id,
    required this.title,
    required this.usersList,
    required this.admin,
  });

  factory Organization.fromJson(Json json) => _$OrganizationFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @JsonKey(name: 'users')
  final List<User> usersList;
  final User admin;

  @override
  List<Object?> get props => [id, title, usersList, admin];
}
