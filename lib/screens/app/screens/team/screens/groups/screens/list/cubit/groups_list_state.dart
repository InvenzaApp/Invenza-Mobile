import 'package:app/enums/api_messages.dart';
import 'package:app/features/group/models/group.dart';
import 'package:equatable/equatable.dart';

class GroupsListState extends Equatable {
  const GroupsListState({
    this.groupsList,
    this.error,
  });

  GroupsListState copyWith({
    List<Group>? groupsList,
    ApiMessages? error,
  }) {
    return GroupsListState(
      groupsList: groupsList ?? this.groupsList,
      error: error ?? this.error,
    );
  }

  final List<Group>? groupsList;
  final ApiMessages? error;

  @override
  List<Object?> get props => [groupsList, error];
}
