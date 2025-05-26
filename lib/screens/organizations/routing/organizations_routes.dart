import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/di.dart';
import 'package:app/guards/auth_guard.dart';
import 'package:auto_route/auto_route.dart';

abstract class OrganizationsRoutes{
  static List<AutoRoute> get() => [
    AutoRoute(
      path: '/organizations',
      page: OrganizationsListRoute.page,
      guards: [
        AuthGuard(
          userCubit: inject<UserCubit>(),
        ),
      ],
    ),
    AutoRoute(
      path: '/organization-create',
      page: OrganizationCreateRoute.page,
    ),
  ];
}
