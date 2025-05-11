import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/shared/select_template/view/i_form_permission_select_page/widgets/i_form_permission_select_widget.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IFormPermissionSelectPanelWidget extends StatefulWidget {
  const IFormPermissionSelectPanelWidget({
    required this.permissionsCategory,
    required this.selectedPermissions,
    super.key,
  });

  final List<String> selectedPermissions;
  final PermissionsCategory permissionsCategory;

  @override
  State<IFormPermissionSelectPanelWidget> createState() =>
      _IFormPermissionSelectPanelWidgetState();
}

class _IFormPermissionSelectPanelWidgetState
    extends State<IFormPermissionSelectPanelWidget> {
  @override
  Widget build(BuildContext context) {
    final userState = context.read<UserCubit>().state;
    final permissionsList = Permissions.getByCategory(
      category: widget.permissionsCategory,
      userPermissions: userState.userResult!.maybeValue!.permissions,
    );

    if(permissionsList.isEmpty) return const SizedBox.shrink();

    return Column(
      spacing: smallValue,
      children: [
        Padding(
          padding: smallHorizontalPadding,
          child: Row(
            spacing: smallValue,
            children: [
              Icon(widget.permissionsCategory.getIcon()),
              Text(
                widget.permissionsCategory.getName(context),
                style: context.bodyMedium,
              ),
            ],
          ),
        ),
        ...permissionsList.map(
          (permission) {
            return IFormPermissionSelectWidget(
              isSelected: widget.selectedPermissions.contains(permission.name),
              permission: permission,
              onChanged: (selected) {
                setState(() {
                  if (widget.selectedPermissions.contains(permission.name)) {
                    widget.selectedPermissions.remove(permission.name);
                  } else {
                    widget.selectedPermissions.add(permission.name);
                  }
                });
              },
            );
          },
        ),
      ],
    );
  }
}
