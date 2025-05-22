import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/cubit/user_cubit/user_state.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsAccountWidget extends StatelessWidget {
  const SettingsAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final user = state.userResult?.maybeValue;
        return Column(
          children: [
            Container(
              padding: mediumPadding,
              decoration: BoxDecoration(
                color: context.primary,
                borderRadius: mediumRadius,
              ),
              child: Icon(
                Icons.person,
                color: context.onPrimary,
                size: xxLargeValue,
              ),
            ),
            SizedBox(height: smallValue),
            Text(
              user?.title ?? '',
              style: context.titleLarge,
            ),
            Text(
              user?.email ?? '',
              style: context.bodyMedium.copyWith(
                color: context.onSurfaceVariant,
              ),
            ),
            SizedBox(height: largeValue),
          ],
        );
      },
    );
  }
}
