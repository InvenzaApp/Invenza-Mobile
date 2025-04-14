import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/screens/app/routing/app_routes.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter{
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/',
      page: LoginRoute.page,
      initial: true,
    ),
    ...AppRoutes.get(),
  ];
}
