import 'package:app/app/routing/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

abstract class UsersRoutes {
  static List<AutoRoute> get() => [
        AutoRoute(
          path: '/users',
          page: UsersListRoute.page,
        ),
        AutoRoute(
          path: '/users/:id',
          page: UsersShowRoute.page,
        ),
        AutoRoute(
          path: '/user-create',
          page: UsersCreateFormRoute.page,
        ),
      ];
}
