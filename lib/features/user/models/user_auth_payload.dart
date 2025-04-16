import 'package:app/type_def/json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_auth_payload.g.dart';

@JsonSerializable()
class UserAuthPayload {
  const UserAuthPayload({
    required this.email,
    required this.password,
  });

  factory UserAuthPayload.fromJson(Map<String, dynamic> json) =>
      _$UserAuthPayloadFromJson(json);

  final String email;
  final String password;

  Json toJson() => _$UserAuthPayloadToJson(this);
}
