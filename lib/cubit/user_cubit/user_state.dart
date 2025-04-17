import 'package:app/enums/api_messages.dart';
import 'package:app/features/organization/models/organization.dart';
import 'package:app/features/user/models/user.dart';
import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  const UserState({
    this.user,
    this.organization,
    this.error,
    this.isLoading = false,
  });

  final User? user;
  final Organization? organization;
  final bool isLoading;
  final ApiMessages? error;

  UserState copyWith({
    User? user,
    Organization? organization,
    bool? isLoading,
    ApiMessages? error,
  }) =>
      UserState(
        user: user ?? this.user,
        organization: organization ?? this.organization,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [user, organization, isLoading];
}
