import 'package:app/core/result/result.dart';
import 'package:app/features/organization/models/organization.dart';
import 'package:app/features/user/models/user.dart';
import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  const UserState({
    this.userResult,
    this.organizationResult,
    this.isLoading = false,
  });

  final Result<User>? userResult;
  final Result<Organization>? organizationResult;
  final bool isLoading;

  UserState copyWith({
    Result<User>? userResult,
    Result<Organization>? organizationResult,
    bool? isLoading,
  }) =>
      UserState(
        userResult: userResult ?? this.userResult,
        organizationResult: organizationResult ?? this.organizationResult,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [userResult, organizationResult, isLoading];
}
