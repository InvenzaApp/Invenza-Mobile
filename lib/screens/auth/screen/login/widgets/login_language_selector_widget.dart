import 'package:app/cubit/locale_cubit.dart';
import 'package:app/screens/auth/screen/login/enums/language_enum.dart';
import 'package:app/screens/auth/screen/login/widgets/login_language_selector_language_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginLanguageSelectorWidget extends StatelessWidget {
  const LoginLanguageSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, state) {
        return const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoginLanguageSelectorLanguageWidget(
              language: LanguageEnum.pl,
            ),
            LoginLanguageSelectorLanguageWidget(
              language: LanguageEnum.en,
            ),
          ],
        );
      },
    );
  }
}
