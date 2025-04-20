import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IAlertWidget extends StatelessWidget {
  const IAlertWidget({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: mediumPadding,
      decoration: BoxDecoration(
        color: context.errorContainer,
        borderRadius: mediumRadius,
      ),
      child: Column(
        spacing: mediumValue,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            spacing: mediumValue,
            children: [
              Icon(Icons.warning, color: context.onErrorContainer),
              Text(
                context.l10n.notification,
                style: context.titleSmall.copyWith(
                  color: context.onPrimaryContainer,
                ),
              ),
            ],
          ),
          Text(
            message,
            style: context.bodyMedium.copyWith(color: context.onErrorContainer),
          ),
        ],
      ),
    );
  }
}
