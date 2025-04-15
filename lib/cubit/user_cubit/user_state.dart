import 'package:app/core/result/result.dart';
import 'package:app/models/user/user.dart';
import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  const UserState({
    required this.result,
    this.isLoading = false,
  });

  final Result<User> result;
  final bool isLoading;

  UserState copyWith({
    Result<User>? result,
    bool? isLoading,
  }) =>
      UserState(
        result: result ?? this.result,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [result, isLoading];
}
