import 'package:app/app/routing/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

abstract class TasksRoutes {
  static List<AutoRoute> get() => [
        AutoRoute(
          path: '/task-form',
          page: TasksFormRoute.page,
        ),
      ];
}
