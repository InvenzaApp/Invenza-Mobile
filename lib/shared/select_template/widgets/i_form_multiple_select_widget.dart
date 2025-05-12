import 'package:app/core/cockpit_repository/cockpit_repository.dart';
import 'package:app/core/entity/item_entity.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/shared/form_template/i_form_template.dart';
import 'package:app/shared/select_template/view/i_form_multiple_select_page.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class IFormMultipleSelectWidget<T extends ItemEntity> extends IFormStatefulWidget {
  const IFormMultipleSelectWidget({
    required this.repository,
    required this.name,
    this.title,
    this.label,
    this.subtitle,
    this.initialIdList,
    this.dontBuildWithId,
    this.validator,
    super.key,
  });

  final CockpitRepository repository;
  final String name;
  final String? label;
  final String? title;
  final String? subtitle;
  final List<int>? initialIdList;
  final int? dontBuildWithId;
  final FormFieldValidator<dynamic>? validator;

  @override
  State<IFormMultipleSelectWidget> createState() =>
      _IFormMultipleSelectWidgetState<T>();
}

class _IFormMultipleSelectWidgetState<T extends ItemEntity>
    extends State<IFormMultipleSelectWidget> {
  List<int> selectedEntities = [];

  late int length;

  @override
  void initState() {
    super.initState();

    if (widget.initialIdList?.isNotEmpty ?? false) {
      selectedEntities = widget.initialIdList!;
    }

    length = selectedEntities.length;

    if (widget.dontBuildWithId != null &&
        selectedEntities.contains(widget.dontBuildWithId)) {
      length--;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: widget.name,
      validator: widget.validator,
      initialValue: selectedEntities,
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
                    dontBuildWithId: widget.dontBuildWithId,
                  ),
                );

                if (result is List<int>) {
                  selectedEntities = result;
                }

                length = selectedEntities.length;

                field.didChange(selectedEntities);

                if (selectedEntities.isEmpty) {
                  field.didChange(null);
                }

                if (widget.dontBuildWithId != null &&
                    selectedEntities.contains(widget.dontBuildWithId)) {
                  length--;
                }

                setState(() {});
              },
              borderRadius: BorderRadius.circular(mediumValue),
              child: Ink(
                padding: mediumPadding,
                decoration: BoxDecoration(
                  color: field.hasError
                      ? context.errorContainer
                      : length == 0
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
                        Text(
                          length == 0
                              ? (widget.subtitle ?? context.l10n.tap_to_select)
                              : '${context.l10n.selected}: $length',
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
