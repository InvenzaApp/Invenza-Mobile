import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/core/show/cubit/show_cubit.dart';
import 'package:app/features/calendar/models/event.dart';
import 'package:app/features/calendar/network/calendar_repository.dart';

class CalendarShowCubit extends ShowCubit<Event> {
  CalendarShowCubit({
    required this.resourceId,
    required this.repository,
  }) : super(editRoute: CalendarUpdateRoute(resourceId: resourceId));

  @override
  final CalendarRepository repository;

  @override
  final int resourceId;

  @override
  Future<void> delete() async {
    await repository.delete(resourceId);
  }

  @override
  Future<void> initialize() async {
    super.emitState(isLoading: true);
    final result = await repository.get(resourceId);
    super.emitState(isLoading: false, data: result);
  }
}
