import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/cubit/user_cubit/user_state.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsOrganizationWidget extends StatelessWidget {
  const SettingsOrganizationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => context.router.replaceAll([const OrganizationsRoute()]),
          child: Ink(
            padding: mediumPadding,
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(color: context.outline),
              ),
            ),
            child: Row(
              spacing: mediumValue,
              children: [
                Padding(
                  padding: smallPadding,
                  child: Icon(
                    Icons.business,
                    color: context.primary,
                  ),
                ),
                Expanded(
                  child: Text(
                    state.organizationsList
                        .firstWhere(
                          (e) => e.id == state.selectedOrganizationId!,
                        )
                        .title,
                    style: context.bodyMedium,
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        );
      },
    );
  }
}
