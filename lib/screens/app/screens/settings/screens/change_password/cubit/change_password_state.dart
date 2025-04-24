import 'package:equatable/equatable.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.isLoading = false,
  });

  final bool isLoading;

  @override
  List<Object?> get props => [isLoading];
}
