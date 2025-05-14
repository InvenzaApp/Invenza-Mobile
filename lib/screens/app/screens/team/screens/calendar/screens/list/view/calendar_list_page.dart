import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/core/user_permissions/user_permissions.dart';
import 'package:app/di.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/features/calendar/models/event.dart';
import 'package:app/features/calendar/network/calendar_remote_data_source.dart';
import 'package:app/features/calendar/network/calendar_repository.dart';
import 'package:app/screens/app/screens/team/screens/calendar/cubit/calendar_cubit.dart';
import 'package:app/screens/app/screens/team/screens/calendar/cubit/calendar_state.dart';
import 'package:app/screens/app/screens/team/screens/calendar/screens/list/widgets/calendar_list_widget.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_loading_widget.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

@RoutePage()
class CalendarListPage extends StatefulWidget implements AutoRouteWrapper {
  const CalendarListPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => CalendarCubit(
        repository: CalendarRepository(
          remoteDS: inject<CalendarRemoteDataSource>(),
        ),
      ),
      child: this,
    );
  }

  @override
  State<CalendarListPage> createState() => _CalendarListPageState();
}

class _CalendarListPageState extends State<CalendarListPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  bool _selectedEventsInitialized = false;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  List<Event> _getEventsForDay(List<Event> eventsList, DateTime day) {
    return eventsList.where((e) => isSameDay(e.dateFrom, day)).toList();
  }

  void _onDaySelected(
    List<Event> eventsList,
    DateTime selectedDay,
    DateTime focusedDay,
  ) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _selectedEvents.value = _getEventsForDay(eventsList, selectedDay);
    });
  }

  void _onDeleted() {
    setState(() {
      _selectedEvents.value = _getEventsForDay(
        context.read<CalendarCubit>().state.eventsList,
        _selectedDay,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);

    return Scaffold(
      appBar: iAppBar(
        title: context.l10n.calendar_list_app_bar,
        context: context,
      ),
      floatingActionButton: UserPermissions.hasPermission(
        Permissions.add_calendar,
      )
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () async {
                final cubit = context.read<CalendarCubit>();
                final needUpdate =
                    await context.pushRoute(const CalendarCreateRoute());

                if (needUpdate == true) {
                  await cubit.fetchEvents();
                }
                if (!context.mounted) return;

                setState(() {
                  _selectedEvents.value =
                      _getEventsForDay(cubit.state.eventsList, _selectedDay);
                });
              },
            )
          : null,
      body: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) {
          if (!state.isLoading && !_selectedEventsInitialized) {
            _selectedEvents =
                ValueNotifier(_getEventsForDay(state.eventsList, _selectedDay));
            _selectedEventsInitialized = true;
          }
          return switch (state.isLoading) {
            true => const ILoadingWidget(),
            false => Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: context.surface,
                    ),
                    child: TableCalendar<Event>(
                      focusedDay: _focusedDay,
                      firstDay: DateTime(1970),
                      lastDay: DateTime(2100),
                      locale: locale.languageCode,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        return _onDaySelected(
                          state.eventsList,
                          selectedDay,
                          focusedDay,
                        );
                      },
                      eventLoader: (day) =>
                          _getEventsForDay(state.eventsList, day),
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month',
                      },
                      calendarStyle: CalendarStyle(
                        weekendTextStyle: TextStyle(color: context.primary),
                      ),
                    ),
                  ),
                  SizedBox(height: mediumValue),
                  Expanded(
                    child: ValueListenableBuilder<List<Event>>(
                      valueListenable: _selectedEvents,
                      builder: (context, value, _) {
                        return ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            final event = value[index];

                            return CalendarListWidget(
                              event: event,
                              onDeleted: _onDeleted,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              )
          };
        },
      ),
    );
  }
}
