import 'dart:convert';

import 'package:app/core/cockpit_repository/cockpit_repository.dart';
import 'package:app/core/result/result.dart';
import 'package:app/extensions/result_extension.dart';
import 'package:app/features/organization/models/organization.dart';
import 'package:app/features/organization/network/organization_remote_data_source.dart';
import 'package:app/type_def/json.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class OrganizationRepository extends CockpitRepository {
  OrganizationRepository({
    required this.remoteDS,
    @Named('httpClient') required Dio dio,
  }) : _authDio = dio;

  final Dio _authDio;

  @override
  final OrganizationRemoteDataSource remoteDS;

  @override
  Future<Result<int>> create(Json payload) {
    return remoteDS.create(payload).asResult<int>();
  }

  @override
  Future<void> delete(int resourceId) {
    throw UnsupportedError('OrganizationRepository does not support delete');
  }

  @override
  Future<Result<Organization>> get(int resourceId) {
    return remoteDS
        .get(resourceId)
        .asResult<Organization>(fromJson: Organization.fromJson);
  }

  @override
  Future<Result<List<Organization>>> getAll() async {
    return remoteDS
        .getAll()
        .asListResult<Organization>(fromJson: Organization.fromJson);
  }

  @override
  Future<Result<int>> update(int resourceId, Json payload) async {
    return remoteDS.update(resourceId, payload).asResult<int>();
  }

  Future<Result<bool>> selectOrganization(int organizationId) async {
    return _authDio
        .post<String>(
          '/api/organization/select-organization',
          data: {
            'organizationId': organizationId,
          },
        )
        .then((res) => jsonDecode(res.data!) as Json)
        .asResult<bool>();
  }
}
