import 'package:app/extensions/app_localizations.dart';
import 'package:flutter/material.dart';

enum TaskStatus{
  toDo,
  inProgress,
  waiting,
  testing,
  review,
  done;

  static TaskStatus fromJson(String json){
    return TaskStatus.values.byName(json);
  }

  static String toJson(TaskStatus status){
    return status.name;
  }

  String getName(BuildContext context) => switch(this){
    toDo => context.l10n.task_status_to_do,
    inProgress => context.l10n.task_status_in_progress,
    waiting => context.l10n.task_status_waiting,
    testing => context.l10n.task_status_testing,
    review => context.l10n.task_status_review,
    done => context.l10n.task_status_done,
  };
}
