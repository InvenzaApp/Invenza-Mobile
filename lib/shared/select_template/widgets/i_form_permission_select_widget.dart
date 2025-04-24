import 'package:app/core/entity/entity.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/shared/form_template/i_form_template.dart';
import 'package:app/shared/select_template/view/i_form_permission_select_page.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class IFormPermissionSelectWidget<T extends Entity>
    extends IFormStatefulWidget {
  const IFormPermissionSelectWidget({
    this.initialList,
    super.key,
  });

  final List<String>? initialList;

  @override
  State<IFormPermissionSelectWidget> createState() =>
      _IFormMultipleSelectWidgetState<T>();
}

class _IFormMultipleSelectWidgetState<T extends Entity>
    extends State<IFormPermissionSelectWidget> {
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

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: 'permissions',
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.permissions_widget_label,
              style: context.bodyMedium,
            ),
            InkWell(
              onTap: () async {
                final result = await context.router.pushWidget(
                  IFormPermissionSelectPage(
                    initialList: selectedEntities,
                  ),
                );

                if (result is List<String>) {
                  selectedEntities = result;
                }

                field.didChange(selectedEntities);

                if (selectedEntities.isEmpty) {
                  field.didChange(null);
                }

                setState(() {});
              },
              borderRadius: BorderRadius.circular(mediumValue),
              child: Ink(
                padding: mediumPadding,
                decoration: BoxDecoration(
                  color: field.hasError
                      ? context.errorContainer
                      : selectedEntities.isEmpty
                          ? context.container
                          : context.primaryContainer,
                  borderRadius: smallRadius,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.permissions_widget_title,
                          style: context.titleSmall,
                        ),
                        Text(
                          selectedEntities.isEmpty
                              ? context.l10n.permissions_widget_subtitle
                              : '${context.l10n.selected}: ${selectedEntities.length}',
                          style: context.bodyMedium,
                        ),
                        if (field.hasError)
                          Text(
                            field.errorText!,
                            style: context.bodyMedium.copyWith(
                              color: context.error,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
