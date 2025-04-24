import 'package:app/extensions/app_localizations.dart';
import 'package:app/type_def/json.dart';
import 'package:flutter/material.dart';

enum Permissions{
  addUser,
  listUser,
  showUser,
  updateUser,
  deleteUser,
  addGroup,
  listGroup,
  showGroup,
  updateGroup,
  deleteGroup,
  addTask,
  listTask,
  showTask,
  updateTask,
  deleteTask;

  static Permissions fromSingleJson(dynamic json){
    return Permissions.values.byName(json as String);
  }

  static List<Permissions> fromJson(List<dynamic> json) {
    return json
        .map((e) => Permissions.values.byName(e as String))
        .toList();
  }

  static List<String> toJson(List<Permissions> permissions){
    return permissions.map((e) => e.name).toList();
  }

  String getName(BuildContext context) => switch(this){
    addUser => context.l10n.permissions_add_user,
    listUser => context.l10n.permissions_list_user,
    showUser => context.l10n.permissions_show_user,
    updateUser => context.l10n.permissions_update_user,
    deleteUser => context.l10n.permissions_delete_user,
    addGroup => context.l10n.permissions_add_group,
    listGroup => context.l10n.permissions_list_group,
    showGroup => context.l10n.permissions_show_group,
    updateGroup => context.l10n.permissions_update_group,
    deleteGroup => context.l10n.permissions_delete_group,
    addTask => context.l10n.permissions_add_task,
    listTask => context.l10n.permissions_list_task,
    showTask => context.l10n.permissions_show_task,
    updateTask => context.l10n.permissions_update_task,
    deleteTask => context.l10n.permissions_delete_task,
  };
}
