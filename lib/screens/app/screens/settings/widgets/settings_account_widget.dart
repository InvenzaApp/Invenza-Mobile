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
        return Container(
          padding: mediumPadding,
          decoration: BoxDecoration(
            color: context.surface,
          ),
          child: Container(
            padding: mediumPadding,
            decoration: BoxDecoration(
              color: context.container,
              borderRadius: mediumRadius,
            ),
            child: Row(
              spacing: mediumValue,
              children: [
                Container(
                  padding: smallPadding,
                  decoration: BoxDecoration(
                    color: context.primary,
                    borderRadius: smallRadius,
                  ),
                  child: Icon(
                    Icons.person,
                    color: context.onPrimary,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.userResult?.maybeValue?.title ?? '',
                      style: context.bodyMedium,
                    ),
                    Text(
                      state.userResult?.maybeValue?.email ?? '',
                      style: context.bodySmall.copyWith(
                        color: context.onSurfaceVariant,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
