import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/screens/app/screens/settings/routing/settings_routes.dart';
import 'package:auto_route/auto_route.dart';

abstract class AppRoutes {
  static List<AutoRoute> get() => [
        AutoRoute(
          path: '/asd',
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
            AutoRoute(
              path: 'settings',
              page: SettingsRoute.page,
            ),
          ],
        ),
        ...SettingsRoutes.get(),
      ];
}
