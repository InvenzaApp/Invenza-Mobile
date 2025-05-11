import 'package:app/core/entity/item_entity.dart';
import 'package:app/features/address/models/address.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/type_def/json.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization.g.dart';

@JsonSerializable(createToJson: false)
class Organization extends ItemEntity with EquatableMixin {
  Organization({
    required this.id,
    required this.title,
    required this.usersList,
    required this.admin,
    required this.address,
    required this.locked,
  });

  factory Organization.fromJson(Json json) => _$OrganizationFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @JsonKey(name: 'users')
  final List<User> usersList;
  final User admin;
  final Address address;
  @override
  final bool locked;

  @override
  List<Object?> get props => [id, title, usersList, admin, address, locked];
}
