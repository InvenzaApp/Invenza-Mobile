import 'package:app/cubit/locale_cubit.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/screens/auth/screen/login/enums/language_enum.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginLanguageSelectorLanguageWidget extends StatelessWidget {
  const LoginLanguageSelectorLanguageWidget({
    required this.language,
    super.key,
  });

  final LanguageEnum language;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, state) {
        return InkWell(
          borderRadius: BorderRadius.circular(smallValue),
          onTap: () =>
              context.read<LocaleCubit>().changeLocale(Locale(language.name)),
          child: Ink(
            decoration: BoxDecoration(
              color: state == Locale(language.name)
                  ? context.primaryContainer
                  : null,
              borderRadius: smallRadius,
            ),
            child: Padding(
              padding: smallPadding,
              child: Image.asset(
                'assets/images/languages/${language.name}.png',
                width: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}
