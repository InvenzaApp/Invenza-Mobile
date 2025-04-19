import 'package:app/core/result/result.dart';
import 'package:app/features/group/models/group.dart';
import 'package:equatable/equatable.dart';

class GroupsShowState extends Equatable {
  const GroupsShowState({
    this.result,
  });

  final Result<Group>? result;

  @override
  List<Object?> get props => [result];
}
