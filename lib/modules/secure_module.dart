import 'dart:convert';

import 'package:app/features/user/models/user_auth_payload.dart';
import 'package:app/type_def/json.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureModule{
  static const userKey = 'user';
  static const organizationIdKey = 'organizationId';
  final storage = const FlutterSecureStorage();

  Future<void> saveUserCredentials(UserAuthPayload payload) async{
    await storage.write(key: userKey, value: jsonEncode(payload.toJson()));
  }

  Future<UserAuthPayload?> getUserCredentials() async{
    final value = await storage.read(key: userKey);

    if(value == null) return null;

    final json = jsonDecode(value);
    return UserAuthPayload.fromJson(json as Json);
  }

  Future<void> deleteUserCredentials() async{
    await storage.delete(key: userKey);
  }

  Future<void> saveOrganizationId(int organizationId) async{
    await storage.write(key: organizationIdKey, value: organizationId.toString());
  }

  Future<int?> getOrganizationId() async{
    final value = await storage.read(key: organizationIdKey);
    if(value == null) return null;
    return int.parse(value);
  }

  Future<void> deleteOrganization() async{
    await storage.delete(key: organizationIdKey);
  }
}
