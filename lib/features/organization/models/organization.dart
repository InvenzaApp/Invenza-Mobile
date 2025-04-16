import 'package:app/type_def/json.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization.g.dart';

@JsonSerializable()
class Organization extends Equatable {
  const Organization({
    required this.id,
    required this.name,
  });

  factory Organization.fromJson(Json json) => _$OrganizationFromJson(json);

  final int id;
  final String name;

  Json toJson() => _$OrganizationToJson(this);

  @override
  List<Object?> get props => [id, name];
}
