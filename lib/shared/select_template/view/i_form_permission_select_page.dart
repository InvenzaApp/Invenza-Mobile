import 'package:app/core/entity/entity.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_button.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class IFormPermissionSelectPage extends StatefulWidget {
  const IFormPermissionSelectPage({
    this.initialList,
    super.key,
  });

  final List<Permissions>? initialList;

  @override
  State<IFormPermissionSelectPage> createState() =>
      _IFormPermissionSelectPageState();
}

class _IFormPermissionSelectPageState
    extends State<IFormPermissionSelectPage> {
  List<Permissions> selectedEntities = [];

  @override
  void initState() {
    super.initState();

    if (widget.initialList?.isNotEmpty ?? false) {
      setState(() {
        selectedEntities = widget.initialList!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: iAppBar(
        context: context,
        title: l10n.select,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: mediumPadding,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: Permissions.values.length,
                itemBuilder: (context, index) {
                  final permission = Permissions.values[index];

                  return Column(
                    children: [
                      _IFormPermissionSelectWidget(
                        isSelected:
                        selectedEntities.contains(permission),
                        permission: permission,
                        onChanged: (selected) {
                          setState(() {
                            if (selectedEntities
                                .contains(permission)) {
                              selectedEntities.remove(permission);
                            } else {
                              selectedEntities.add(permission);
                            }
                          });
                        },
                      ),
                      SizedBox(height: mediumValue),
                    ],
                  );
                },
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

class _IFormPermissionSelectWidget extends StatelessWidget {
  const _IFormPermissionSelectWidget({
    required this.isSelected,
    required this.permission,
    required this.onChanged,
  });

  final bool isSelected;
  final Permissions permission;
  final void Function(bool selected) onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!isSelected),
      borderRadius: BorderRadius.circular(mediumValue),
      child: Ink(
        padding: largePadding,
        decoration: BoxDecoration(
          color: isSelected ? context.primaryContainer : context.container,
          borderRadius: mediumRadius,
        ),
        child: Row(
          spacing: mediumValue,
          children: [
            Icon(isSelected ? Icons.check_circle : Icons.circle_outlined),
            Text(
              permission.name,
            ),
          ],
        ),
      ),
    );
  }
}
