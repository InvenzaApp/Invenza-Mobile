import 'package:app/core/result/result.dart';
import 'package:app/features/organization/models/organization.dart';
import 'package:app/features/user/models/user.dart';
import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  const UserState({
    required this.user,
    required this.organization,
    this.isLoading = false,
  });

  final Result<User> user;
  final Result<Organization> organization;
  final bool isLoading;

  UserState copyWith({
    Result<User>? user,
    Result<Organization>? organization,
    bool? isLoading,
  }) =>
      UserState(
        user: user ?? this.user,
        organization: organization ?? this.organization,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [user, organization, isLoading];
}
