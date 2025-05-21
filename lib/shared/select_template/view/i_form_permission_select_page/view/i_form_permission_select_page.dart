import 'package:app/core/entity/entity.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/user_extension.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/shared/select_template/view/i_form_permission_select_page/widgets/i_form_permission_select_panel_widget.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_button.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IFormPermissionSelectPage extends StatefulWidget {
  const IFormPermissionSelectPage({
    this.initialList,
    super.key,
  });

  final List<String>? initialList;

  @override
  State<IFormPermissionSelectPage> createState() =>
      _IFormPermissionSelectPageState();
}

class _IFormPermissionSelectPageState extends State<IFormPermissionSelectPage> {
  List<String> selectedEntities = [];

  @override
  void initState() {
    super.initState();

    if (widget.initialList?.isNotEmpty ?? false) {
      setState(() {
        selectedEntities = widget.initialList!;
      });
    }
  }

  void onSelectAll(User user) {
    setState(() {
      selectedEntities = Permissions.values
          .where((e) {
            return user.hasAccessToPermission(e);
          })
          .map((e) => e.name)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state.userResult!.maybeValue!;
    final l10n = context.l10n;

    return Scaffold(
      appBar: iAppBar(
        context: context,
        title: l10n.select,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.surface,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => onSelectAll(user),
                  child: Text(l10n.selectAll),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedEntities = [];
                    });
                  },
                  child: Text(l10n.unselectAll),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: mediumPadding,
              child: SingleChildScrollView(
                child: Column(
                  spacing: xxLargeValue,
                  children: [
                    IFormPermissionSelectPanelWidget(
                      permissionsCategory: PermissionsCategory.user,
                      selectedPermissions: selectedEntities,
                    ),
                    IFormPermissionSelectPanelWidget(
                      permissionsCategory: PermissionsCategory.group,
                      selectedPermissions: selectedEntities,
                    ),
                    IFormPermissionSelectPanelWidget(
                      permissionsCategory: PermissionsCategory.task,
                      selectedPermissions: selectedEntities,
                    ),
                    IFormPermissionSelectPanelWidget(
                      permissionsCategory: PermissionsCategory.calendar,
                      selectedPermissions: selectedEntities,
                    ),
                    IFormPermissionSelectPanelWidget(
                      permissionsCategory: PermissionsCategory.organization,
                      selectedPermissions: selectedEntities,
                    ),
                    IFormPermissionSelectPanelWidget(
                      permissionsCategory: PermissionsCategory.other,
                      selectedPermissions: selectedEntities,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: largePadding,
            decoration: BoxDecoration(
              color: context.container,
            ),
            child: Column(
              children: [
                IButton(
                  label: l10n.save,
                  onPressed: () {
                    if (selectedEntities.isEmpty) {
                      context.maybePop(<Entity>[]);
                    } else {
                      context.maybePop(selectedEntities);
                    }
                  },
                ),
                SizedBox(height: mediumValue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
