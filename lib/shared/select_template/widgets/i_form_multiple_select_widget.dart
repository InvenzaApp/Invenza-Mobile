import 'package:app/core/cockpit_repository/cockpit_repository.dart';
import 'package:app/core/entity/entity.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/shared/form_template/i_form_template.dart';
import 'package:app/shared/select_template/view/i_form_multiple_select_page.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class IFormMultipleSelectWidget<T extends Entity> extends IFormStatefulWidget {
  const IFormMultipleSelectWidget({
    required this.repository,
    required this.name,
    this.title,
    this.label,
    this.subtitle,
    this.initialIdList,
    super.key,
  });

  final CockpitRepository repository;
  final String name;
  final String? label;
  final String? title;
  final String? subtitle;
  final List<int>? initialIdList;

  @override
  State<IFormMultipleSelectWidget> createState() =>
      _IFormMultipleSelectWidgetState<T>();
}

class _IFormMultipleSelectWidgetState<T extends Entity>
    extends State<IFormMultipleSelectWidget> {
  List<int> selectedEntities = [];

  @override
  void initState() {
    super.initState();

    if (widget.initialIdList?.isNotEmpty ?? false) {
      setState(() {
        selectedEntities = widget.initialIdList!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: widget.name,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null)
              Text(
                widget.label!,
                style: context.bodyMedium,
              ),
            InkWell(
              onTap: () async {
                final result = await context.router.pushWidget(
                  IFormMultipleSelectPage<T>(
                    name: widget.name,
                    repository: widget.repository,
                    initialIdList: selectedEntities,
                  ),
                );

                if (result is List<int>) {
                  setState(() {
                    selectedEntities = result;
                  });
                }

                field.didChange(selectedEntities);

                if(selectedEntities.isEmpty){
                  field.didChange(null);
                }
              },
              borderRadius: BorderRadius.circular(mediumValue),
              child: Ink(
                padding: mediumPadding,
                decoration: BoxDecoration(
                  color: selectedEntities.isEmpty
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
                          widget.title ?? context.l10n.select,
                          style: context.titleSmall,
                        ),
                        if (widget.subtitle != null)
                          Text(
                            selectedEntities.isEmpty
                                ? widget.subtitle!
                                : '${context.l10n.selected}: ${selectedEntities.length}',
                            style: context.bodyMedium,
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
