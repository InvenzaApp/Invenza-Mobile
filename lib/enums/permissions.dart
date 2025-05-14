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
  update_organization,
  add_calendar,
  list_calendar,
  show_calendar,
  update_calendar,
  delete_calendar,
  other_account_show,
  other_account_update;

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
        other_account_show => context.l10n.permissions_other_account_show,
        other_account_update => context.l10n.permissions_other_account_update,
        add_calendar => context.l10n.permissions_add_calendar,
        list_calendar => context.l10n.permissions_list_calendar,
        show_calendar => context.l10n.permissions_show_calendar,
        update_calendar => context.l10n.permissions_update_calendar,
        delete_calendar => context.l10n.permissions_delete_calendar,
      };

  static List<Permissions> getByCategory({
    required PermissionsCategory category,
    required List<Permissions> userPermissions,
  }) {
    return Permissions
        .values
        .where((item) => userPermissions.contains(item))
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
  organization,
  calendar,
  other;

  String getName(BuildContext context) => switch (this) {
        user => context.l10n.permissions_category_users,
        group => context.l10n.permissions_category_groups,
        task => context.l10n.permissions_category_tasks,
        organization => context.l10n.permissions_category_organization,
        other => context.l10n.permissions_category_other,
        calendar => context.l10n.permissions_category_calendar,
      };

  IconData getIcon() => switch (this) {
        user => Icons.person,
        group => Icons.groups,
        task => Icons.task,
        organization => Icons.business,
        calendar => Icons.calendar_month,
        other => Icons.info,
      };
}

enum PermissionsType {
  add,
  list,
  show,
  update,
  delete;
}
