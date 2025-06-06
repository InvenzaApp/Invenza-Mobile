import 'package:app/app/routing/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

abstract class SettingsRoutes {
  static List<AutoRoute> get() => [
        AutoRoute(
          path: '/theme',
          page: ThemeRoute.page,
        ),
        AutoRoute(
          path: '/language',
          page: LanguageRoute.page,
        ),
        AutoRoute(
          path: '/change_password',
          page: ChangePasswordRoute.page,
        ),
        AutoRoute(
          path: '/account',
          page: AccountRoute.page,
        ),
        AutoRoute(
          path: '/organization-show',
          page: OrganizationShowRoute.page,
        ),
        AutoRoute(
          path: '/organization-update',
          page: OrganizationUpdateRoute.page,
        ),
      ];
}
