import 'package:equatable/equatable.dart';

class AccountState extends Equatable {
  const AccountState({
    this.isLoading = false,
  });

  final bool isLoading;

  @override
  List<Object?> get props => [isLoading];
}
