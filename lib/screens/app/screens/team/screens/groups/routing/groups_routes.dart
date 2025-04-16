import 'package:app/app/routing/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

abstract class GroupsRoutes {
  static List<AutoRoute> get() => [
        AutoRoute(
          path: '/groups',
          page: GroupsListRoute.page,
        ),
      ];
}
