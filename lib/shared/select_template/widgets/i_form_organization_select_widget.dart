import 'package:app/core/entity/entity.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/shared/form_template/i_form_template.dart';
import 'package:app/shared/select_template/view/i_form_organization_select_page/view/i_form_organization_select_page.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class IFormOrganizationSelectWidget<T extends Entity>
    extends IFormStatefulWidget {
  const IFormOrganizationSelectWidget({
    this.initialList,
    super.key,
  });

  final List<int>? initialList;

  @override
  State<IFormOrganizationSelectWidget> createState() =>
      _IFormMultipleSelectWidgetState<T>();
}

class _IFormMultipleSelectWidgetState<T extends Entity>
    extends State<IFormOrganizationSelectWidget> {
  List<int> selectedEntities = [];
  late int length;

  @override
  void initState() {
    super.initState();

    selectedEntities =
        (widget.initialList?.isNotEmpty ?? false) ? widget.initialList! : [];

    length = selectedEntities.length;

    if(selectedEntities.contains(context.read<UserCubit>().state.selectedOrganizationId)){
      length--;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderField(
      name: 'organizationsIdList',
      initialValue: selectedEntities,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.organization_select_label,
              style: context.bodyMedium,
            ),
            InkWell(
              onTap: () async {
                final selectedOrganizationId =
                    context.read<UserCubit>().state.selectedOrganizationId!;
                final result = await context.router.pushWidget(
                  IFormOrganizationSelectPage(
                    initialList: selectedEntities,
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

                if(selectedEntities.contains(selectedOrganizationId)){
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
                          l10n.organization_select_title,
                          style: context.titleSmall,
                        ),
                        Text(
                          length == 0
                              ? l10n.organization_select_subtitle
                              : '${l10n.selected}: $length',
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
