import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/di.dart';
import 'package:app/guards/auth_guard.dart';
import 'package:app/screens/app/routing/app_routes.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter{
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/login',
      page: LoginRoute.page,
    ),
    AutoRoute(
      path: '/organizations',
      page: OrganizationsRoute.page,
      guards: [
        AuthGuard(
          userCubit: inject<UserCubit>(),
        ),
      ],
    ),
    ...AppRoutes.get(),
  ];
}
