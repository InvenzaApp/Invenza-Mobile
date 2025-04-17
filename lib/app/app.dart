import 'package:app/app/routing/app_router.dart';
import 'package:app/app_locale.dart';
import 'package:app/app_theme.dart';
import 'package:app/cubit/locale_cubit.dart';
import 'package:app/cubit/theme_cubit.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  static final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LocaleCubit()),
        BlocProvider(create: (_) => inject<UserCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, theme) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp.router(
                localizationsDelegates: appLocalizationsDelegates,
                supportedLocales: appSupportedLocales,
                routerConfig: _appRouter.config(),
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: theme,
                locale: locale,
              );
            },
          );
        },
      ),
    );
  }
}
