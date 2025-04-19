import 'package:app/core/result/result.dart';
import 'package:app/features/group/models/group.dart';
import 'package:equatable/equatable.dart';

class GroupsShowState extends Equatable {
  const GroupsShowState({
    this.result,
    this.isLoading = false,
  });

  GroupsShowState copyWith({
    Result<Group>? result,
    bool? isLoading,
  }) {
    return GroupsShowState(
      result: result ?? this.result,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final Result<Group>? result;
  final bool isLoading;

  @override
  List<Object?> get props => [result, isLoading];
}
