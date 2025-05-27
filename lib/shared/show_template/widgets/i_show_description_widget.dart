import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:flutter/material.dart';

class IShowDescriptionWidget extends StatelessWidget {
  const IShowDescriptionWidget({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.task_show_description,
          style: context.titleMedium,
        ),
        Text(
          text,
          style: context.bodyMedium.copyWith(color: context.onSurfaceVariant),
        ),
      ],
    );
  }
}
