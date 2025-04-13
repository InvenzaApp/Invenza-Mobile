import 'package:app/app/routing/app_router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});
  static final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
