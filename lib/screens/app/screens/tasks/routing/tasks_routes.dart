import 'package:app/app/routing/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

abstract class TasksRoutes {
  static List<AutoRoute> get() => [
        AutoRoute(
          path: '/tasks',
          page: TasksListRoute.page,
        ),
        AutoRoute(
          path: '/task/:id',
          page: TasksShowRoute.page,
        ),
        AutoRoute(
          path: '/task-create',
          page: TasksCreateFormRoute.page,
        ),
        AutoRoute(
          path: '/task-update',
          page: TasksUpdateFormRoute.page,
        ),
      ];
}
