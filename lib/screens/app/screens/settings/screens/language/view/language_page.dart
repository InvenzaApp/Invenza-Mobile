import 'package:app/cubit/locale_cubit.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_checkbox.dart';
import 'package:app/variables.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: iAppBar(
        context: context,
        title: l10n.language_app_bar,
      ),
      body: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, state) {
          return Padding(
            padding: largePadding,
            child: Column(
              spacing: smallValue,
              children: [
                ICheckbox<Locale>(
                  title: l10n.language_polish_title,
                  isChecked: state == const Locale('pl'),
                  wantedValue: const Locale('pl'),
                  onChange: (value) => context
                      .read<LocaleCubit>()
                      .changeLocale(const Locale('pl')),
                ),
                ICheckbox<Locale>(
                  title: l10n.language_english_title,
                  isChecked: state == const Locale('en'),
                  wantedValue: const Locale('en'),
                  onChange: (value) => context
                      .read<LocaleCubit>()
                      .changeLocale(const Locale('en')),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
