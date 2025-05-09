import 'package:equatable/equatable.dart';

class OrganizationState extends Equatable {
  const OrganizationState({
    this.isLoading = false,
  });

  final bool isLoading;

  @override
  List<Object?> get props => [isLoading];
}
