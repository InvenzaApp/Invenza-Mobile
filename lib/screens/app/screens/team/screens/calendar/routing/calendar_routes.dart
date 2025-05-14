import 'package:app/app/routing/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

abstract class CalendarRoutes{
  static List<AutoRoute> get() => [
    AutoRoute(
      path: '/calendar-list',
      page: CalendarListRoute.page,
    ),
    AutoRoute(
      path: '/calendar-show',
      page: CalendarShowRoute.page,
    ),
    AutoRoute(
      path: '/event-create',
      page: CalendarCreateRoute.page,
    ),
    AutoRoute(
      path: '/event-update',
      page: CalendarUpdateRoute.page,
    ),
  ];
}
