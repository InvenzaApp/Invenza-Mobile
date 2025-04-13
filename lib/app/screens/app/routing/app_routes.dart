import 'package:app/app/routing/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

abstract class AppRoutes {
  static List<AutoRoute> get() => [
        AutoRoute(
          path: '/',
          page: AppRoute.page,
          children: [
            AutoRoute(
              path: 'dashboard',
              page: DashboardRoute.page,
            ),
            AutoRoute(
              path: 'tasks',
              page: TasksRoute.page,
            ),
            AutoRoute(
              path: 'users',
              page: TeamRoute.page,
            ),
          ],
        ),
      ];
}
