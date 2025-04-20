import 'package:app/enums/api_messages.dart';
import 'package:app/features/group/models/group.dart';
import 'package:equatable/equatable.dart';

class GroupsListState extends Equatable {
  const GroupsListState({
    this.groupsList,
    this.error,
    this.isLoading = false,
  });

  GroupsListState copyWith({
    List<Group>? groupsList,
    ApiMessages? error,
    bool? isLoading,
  }) {
    return GroupsListState(
      groupsList: groupsList ?? this.groupsList,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final List<Group>? groupsList;
  final ApiMessages? error;
  final bool isLoading;

  @override
  List<Object?> get props => [groupsList, error, isLoading];
}
