import 'package:app/features/group/models/group.dart';
import 'package:equatable/equatable.dart';

class GroupsListState extends Equatable {
  const GroupsListState({
    this.groupsList = const [],
  });

  final List<Group> groupsList;

  @override
  List<Object?> get props => [groupsList];
}
