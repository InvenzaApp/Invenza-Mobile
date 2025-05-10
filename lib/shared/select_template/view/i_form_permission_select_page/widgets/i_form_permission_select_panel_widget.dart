import 'package:app/enums/permissions.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/shared/select_template/view/i_form_permission_select_page/widgets/i_form_permission_select_widget.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

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
        ...Permissions.getByCategory(widget.permissionsCategory).map(
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
