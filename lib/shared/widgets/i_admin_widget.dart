import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IAdminWidget extends StatelessWidget {
  const IAdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: smallValue,
        vertical: xSmallValue,
      ),
      decoration: BoxDecoration(
        color: context.primaryContainer,
        borderRadius: xSmallRadius,
      ),
      child: Row(
        spacing: smallValue,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.person,
            size: largeValue,
            color: context.primary,
          ),
          Text(
            context.l10n.users_show_administrator,
            style: context.bodyMedium.copyWith(color: context.primary),
          ),
        ],
      ),
    );
  }
}
