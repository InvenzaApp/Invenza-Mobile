import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/di.dart';
import 'package:app/guards/auth_guard.dart';
import 'package:app/screens/app/screens/settings/routing/settings_routes.dart';
import 'package:app/screens/app/screens/tasks/routing/tasks_routes.dart';
import 'package:app/screens/app/screens/team/routing/team_routes.dart';
import 'package:auto_route/auto_route.dart';

abstract class AppRoutes {
  static List<AutoRoute> get() => [
        AutoRoute(
          path: '/',
          guards: [
            AuthGuard(
              userCubit: inject<UserCubit>(),
            ),
          ],
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
        ...TasksRoutes.get(),
        ...TeamRoutes.get(),
        ...SettingsRoutes.get(),
      ];
}
