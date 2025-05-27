import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/modules/secure_module.dart';
import 'package:auto_route/auto_route.dart';

class OrganizationGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final secure = SecureModule();
    final organizationId = await secure.getOrganizationId();

    if(organizationId != null){
      resolver.next();
      return;
    }

    await router.replaceAll([const OrganizationsListRoute()]);
    resolver.resolveNext(false, reevaluateNext: false);
  }
}
