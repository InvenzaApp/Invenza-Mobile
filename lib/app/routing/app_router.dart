import 'package:app/screens/app/routing/app_routes.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter{
  @override
  List<AutoRoute> get routes => [
    ...AppRoutes.get(),
  ];
}
