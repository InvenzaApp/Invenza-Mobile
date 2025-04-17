import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:auto_route/auto_route.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard({
    required this.userCubit,
  });

  final UserCubit userCubit;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    await userCubit.signInWithSavedCredentials();

    if (userCubit.state.userResult?.isSuccess ?? false) {
      resolver.next();
      return;
    }

    await router.replaceAll([const LoginRoute()]);
    resolver.resolveNext(false, reevaluateNext: false);
  }
}
