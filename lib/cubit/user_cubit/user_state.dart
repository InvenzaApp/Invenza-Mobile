import 'package:app/models/user/user.dart';
import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  const UserState({
    this.user,
    this.isLoading = false,
  });

  final User? user;
  final bool isLoading;

  UserState copyWith({
    User? user,
    bool? isLoading,
  }) =>
      UserState(
        user: user ?? this.user,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [user, isLoading];
}
