import 'package:app/features/calendar/network/calendar_repository.dart';
import 'package:app/screens/app/screens/team/screens/calendar/cubit/calendar_state.dart';
import 'package:app/type_def/json.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit({
    required this.repository,
  }) : super(const CalendarState()) {
    _initialize();
  }

  final CalendarRepository repository;

  Future<void> _initialize() async {
    await fetchEvents();
  }

  Future<void> fetchEvents() async {
    emit(state.copyWith(isLoading: true));
    final success = await repository.getAll();

    emit(
      state.copyWith(
        isLoading: false,
        eventsList: success.isSuccess ? success.maybeValue! : null,
      ),
    );
  }

  Future<void> addEvent(Json payload) async{
    emit(state.copyWith(isLoading: true));
    await repository.create(payload);
    final success = await repository.getAll();

    emit(
      state.copyWith(
        isLoading: false,
        eventsList: success.isSuccess ? success.maybeValue! : null,
      ),
    );
  }
}
