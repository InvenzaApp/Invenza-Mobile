import 'package:app/core/result/result.dart';
import 'package:app/features/organization/models/organization.dart';
import 'package:app/features/user/models/user.dart';
import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  const UserState({
    this.userResult,
    this.organizationResult,
    this.isLoading = false,
    this.selectedOrganizationId,
    this.organizationsList = const [],
  });

  final Result<User>? userResult;
  final Result<Organization>? organizationResult;
  final bool isLoading;
  final int? selectedOrganizationId;
  final List<Organization> organizationsList;

  UserState copyWith({
    Result<User>? userResult,
    Result<Organization>? organizationResult,
    bool? isLoading,
    int? selectedOrganizationId,
    List<Organization>? organizationsList,
  }) =>
      UserState(
        userResult: userResult ?? this.userResult,
        organizationResult: organizationResult ?? this.organizationResult,
        isLoading: isLoading ?? this.isLoading,
        selectedOrganizationId:
            selectedOrganizationId ?? this.selectedOrganizationId,
        organizationsList: organizationsList ?? this.organizationsList,
      );

  @override
  List<Object?> get props => [
        userResult,
        organizationResult,
        isLoading,
        selectedOrganizationId,
        organizationsList,
      ];
}
