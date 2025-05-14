import 'package:app/di.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/calendar/network/calendar_remote_data_source.dart';
import 'package:app/features/calendar/network/calendar_repository.dart';
import 'package:app/features/calendar/use_case/calendar_update_use_case.dart';
import 'package:app/screens/app/screens/team/screens/calendar/screens/form/widgets/calendar_form_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CalendarUpdatePage extends StatelessWidget {
  const CalendarUpdatePage({required this.resourceId, super.key});

  final int resourceId;

  @override
  Widget build(BuildContext context) {
    return CalendarFormWidget(
      useCase: CalendarUpdateUseCase(
        resourceId: resourceId,
        cockpitRepository: CalendarRepository(
          remoteDS: inject<CalendarRemoteDataSource>(),
          title: context.l10n.calendar_update_app_bar,
        ),
      ),
    );
  }
}
