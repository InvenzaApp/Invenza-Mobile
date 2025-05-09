import 'package:app/extensions/app_localizations.dart';
import 'package:flutter/material.dart';

enum Permissions {
  add_user,
  list_user,
  show_user,
  update_user,
  delete_user,
  add_group,
  list_group,
  show_group,
  update_group,
  delete_group,
  add_task,
  list_task,
  show_task,
  update_task,
  delete_task,
  show_organization,
  update_organization;

  static Permissions fromSingleJson(dynamic json) {
    return Permissions.values.byName(json as String);
  }

  static List<Permissions> fromJson(List<dynamic> json) {
    return json.map((e) => Permissions.values.byName(e as String)).toList();
  }

  static List<String> toJson(List<Permissions> permissions) {
    return permissions.map((e) => e.name).toList();
  }

  String getName(BuildContext context) => switch (this) {
        add_user => context.l10n.permissions_add_user,
        list_user => context.l10n.permissions_list_user,
        show_user => context.l10n.permissions_show_user,
        update_user => context.l10n.permissions_update_user,
        delete_user => context.l10n.permissions_delete_user,
        add_group => context.l10n.permissions_add_group,
        list_group => context.l10n.permissions_list_group,
        show_group => context.l10n.permissions_show_group,
        update_group => context.l10n.permissions_update_group,
        delete_group => context.l10n.permissions_delete_group,
        add_task => context.l10n.permissions_add_task,
        list_task => context.l10n.permissions_list_task,
        show_task => context.l10n.permissions_show_task,
        update_task => context.l10n.permissions_update_task,
        delete_task => context.l10n.permissions_delete_task,
        show_organization => context.l10n.permissions_show_organization,
        update_organization => context.l10n.permissions_update_organization,
      };

  static List<Permissions> getByCategory(PermissionsCategory category) {
    return Permissions.values
        .where((item) => item.name.contains(category.name))
        .toList();
  }

  IconData getPermissionTypeIcon() {
    for (final pType in PermissionsType.values) {
      if (name.contains(pType.name)) {
        return switch (pType) {
          PermissionsType.add => Icons.add,
          PermissionsType.list => Icons.list,
          PermissionsType.show => Icons.remove_red_eye,
          PermissionsType.update => Icons.edit,
          PermissionsType.delete => Icons.delete,
        };
      }
    }
    return Icons.help_outline;
  }
}

enum PermissionsCategory {
  user,
  group,
  task,
  organization;

  String getName(BuildContext context) => switch (this) {
        user => context.l10n.permissions_category_users,
        group => context.l10n.permissions_category_groups,
        task => context.l10n.permissions_category_tasks,
        organization => context.l10n.permissions_category_organization,
      };

  IconData getIcon() => switch (this) {
        user => Icons.person,
        group => Icons.groups,
        task => Icons.task,
        organization => Icons.business,
      };
}

enum PermissionsType {
  add,
  list,
  show,
  update,
  delete;
}
