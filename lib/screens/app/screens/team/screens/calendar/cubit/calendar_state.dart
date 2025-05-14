import 'package:app/features/calendar/models/event.dart';
import 'package:equatable/equatable.dart';

class CalendarState extends Equatable {
  const CalendarState({
    this.isLoading = false,
    this.eventsList = const [],
  });

  CalendarState copyWith({
    bool? isLoading,
    List<Event>? eventsList,
  }) {
    return CalendarState(
      isLoading: isLoading ?? this.isLoading,
      eventsList: eventsList ?? this.eventsList,
    );
  }

  final bool isLoading;
  final List<Event> eventsList;

  @override
  List<Object?> get props => [
        isLoading,
        eventsList,
      ];
}
