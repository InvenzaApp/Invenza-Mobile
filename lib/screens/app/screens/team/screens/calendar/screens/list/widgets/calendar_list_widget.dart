import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/core/user_permissions/user_permissions.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/date_time_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/features/calendar/models/event.dart';
import 'package:app/screens/app/screens/team/screens/calendar/cubit/calendar_cubit.dart';
import 'package:app/shared/widgets/i_lock_widget.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarListWidget extends StatelessWidget {
  const CalendarListWidget({
    required this.event,
    required this.onDeleted,
    super.key,
  });

  final Event event;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: mediumHorizontalPadding,
          child: InkWell(
            onTap: () async {
              if(!UserPermissions.hasPermission(Permissions.show_calendar)){
                return;
              }

              final needUpdate = await context.pushRoute(
                CalendarShowRoute(resourceId: event.id),
              );

              if (needUpdate == true && context.mounted) {
                await context.read<CalendarCubit>().fetchEvents();
                onDeleted();
              }
            },
            borderRadius: BorderRadius.circular(mediumValue),
            child: Ink(
              padding: mediumPadding,
              decoration: BoxDecoration(
                color: context.container,
                borderRadius: mediumRadius,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: context.bodyMedium,
                  ),
                  if (event.description != null) ...[
                    Text(
                      event.description!,
                      overflow: TextOverflow.ellipsis,
                      style: context.bodySmall.copyWith(
                        color: context.onSurfaceVariant,
                      ),
                    ),
                  ],
                  SizedBox(height: mediumValue),
                  Row(
                    spacing: smallValue,
                    children: [
                      Icon(
                        Icons.outlined_flag,
                        size: xLargeValue,
                      ),
                      Text(
                        event.dateFrom.formattedDateTime(context),
                        style: context.bodyMedium,
                      ),
                    ],
                  ),
                  if(event.locked)...[
                    const ILockWidget(),
                  ],
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: mediumValue),
      ],
    );
  }
}
