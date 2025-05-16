import 'package:app/di.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/date_time_extension.dart';
import 'package:app/features/calendar/models/event.dart';
import 'package:app/features/calendar/network/calendar_remote_data_source.dart';
import 'package:app/features/calendar/network/calendar_repository.dart';
import 'package:app/screens/app/screens/team/screens/calendar/screens/show/cubit/calendar_show_cubit.dart';
import 'package:app/shared/show_template/i_show_template.dart';
import 'package:app/shared/widgets/i_card/i_card.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CalendarShowPage extends StatelessWidget {
  const CalendarShowPage({required this.resourceId, super.key});

  final int resourceId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return IShowTemplate<Event>(
      cubit: CalendarShowCubit(
        resourceId: resourceId,
        repository: CalendarRepository(
          remoteDS: inject<CalendarRemoteDataSource>(),
          title: l10n.calendar_show_app_bar,
        ),
      ),
      builder: (context, cubit) {
        final event = cubit.data;
        return Padding(
          padding: mediumPadding,
          child: ICard(
            children: [
              ICardItem(
                label: l10n.calendar_show_title,
                value: event.title,
              ),
              if (event.description != null) ...[
                ICardItem(
                  label: l10n.calendar_show_description,
                  value: event.description!,
                ),
              ],
              ICardItem(
                label: l10n.calendar_show_date_from,
                value: event.dateFrom.formattedDateTime(context),
              ),
              ICardItem(
                label: l10n.calendar_show_date_to,
                value: event.dateTo.formattedDateTime(context),
              ),
              if (event.locked) ...[
                ICardItem(
                  label: l10n.locked,
                  value: l10n.yes,
                ),
              ],
            ],
          ),
        );
      },
      updatePermission: Permissions.update_calendar,
      deletePermission: Permissions.delete_calendar,
    );
  }
}
