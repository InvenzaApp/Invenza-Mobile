import 'package:app/core/use_case/use_case.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/calendar/models/event.dart';
import 'package:app/features/calendar/use_case/calendar_update_use_case.dart';
import 'package:app/shared/form_template/i_form_template.dart';
import 'package:app/shared/widgets/i_form_skeletonizer.dart';
import 'package:app/shared/widgets/i_scaffold_error_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CalendarFormWidget extends StatefulWidget {
  const CalendarFormWidget({required this.useCase, super.key});

  final UseCase useCase;

  @override
  State<CalendarFormWidget> createState() => _CalendarFormWidgetState();
}

class _CalendarFormWidgetState extends State<CalendarFormWidget> {
  Event? resources;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (widget.useCase is! UpdateUseCase) return;

    final useCase = widget.useCase as CalendarUpdateUseCase;

    final result = await useCase.cockpitRepository.get(useCase.resourceId);

    setState(() {
      resources = result.isSuccess ? result.maybeValue! : null;
      isError = result.isError;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final user = context.read<UserCubit>().state.userResult!.maybeValue!;

    if (isError) {
      return IScaffoldErrorWidget(
        onPressed: () async => fetchData(),
      );
    }

    if (widget.useCase is UpdateUseCase && resources == null) {
      return const IFormSkeletonizer();
    }

    return IFormTemplate(
      useCase: widget.useCase,
      onSubmit: (_) => context.maybePop(true),
      fields: [
        IFormTextField(
          name: 'title',
          label: l10n.calendar_form_title_label,
          placeholder: l10n.calendar_form_title_placeholder,
          validators: [
            FormBuilderValidators.required(),
          ],
          initialValue: resources?.title,
        ),
        IFormExpandedTextField(
          name: 'description',
          label: l10n.calendar_form_description_label,
          placeholder: l10n.calendar_form_description_placeholder,
          initialValue: resources?.description,
        ),
        IFormDateTime(
          name: 'dateFrom',
          label: l10n.calendar_form_date_from_label,
          placeholder: l10n.calendar_form_date_from_placeholder,
          validators: [
            FormBuilderValidators.required(),
          ],
          valueTransformer: (value) => value?.toIso8601String(),
          initialValue: resources?.dateFrom ?? DateTime.now(),
        ),
        IFormDateTime(
          name: 'dateTo',
          label: l10n.calendar_form_date_to_label,
          placeholder: l10n.calendar_form_date_to_placeholder,
          validators: [
            FormBuilderValidators.required(),
          ],
          valueTransformer: (value) => value?.toIso8601String(),
          initialValue:
              resources?.dateTo ?? DateTime.now().add(const Duration(hours: 1)),
        ),
        if(user.admin)...[
          IFormCheckbox(
            name: 'locked',
            title: l10n.lock_title,
            subtitle: l10n.lock_subtitle,
            initialValue: resources?.locked,
          ),
        ],
      ],
    );
  }
}
