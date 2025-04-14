import 'package:app/cubit/theme_cubit.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_checkbox.dart';
import 'package:app/variables.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: iAppBar(
        context: context,
        title: l10n.theme_app_bar,
      ),
      body: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return Padding(
            padding: largePadding,
            child: Column(
              spacing: smallValue,
              children: [
                ICheckbox<ThemeMode>(
                  title: l10n.theme_light_title,
                  wantedValue: ThemeMode.light,
                  isChecked: state == ThemeMode.light,
                  onChange: context.read<ThemeCubit>().changeTheme,
                  unselectedIcon: Icons.light_mode,
                ),
                ICheckbox<ThemeMode>(
                  title: l10n.theme_dark_title,
                  wantedValue: ThemeMode.dark,
                  isChecked: state == ThemeMode.dark,
                  onChange: context.read<ThemeCubit>().changeTheme,
                  unselectedIcon: Icons.dark_mode,
                ),
                ICheckbox<ThemeMode>(
                  title: l10n.theme_system_title,
                  wantedValue: ThemeMode.system,
                  isChecked: state == ThemeMode.system,
                  onChange: context.read<ThemeCubit>().changeTheme,
                  unselectedIcon: Icons.smartphone,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
