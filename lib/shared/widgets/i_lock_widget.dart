import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class ILockWidget extends StatelessWidget {
  const ILockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: mediumValue),
        Row(
          spacing: smallValue,
          children: [
            Tooltip(
              message: context.l10n.locked_hint,
              triggerMode: TooltipTriggerMode.tap,
              child: Icon(
                Icons.info_outline,
                size: xLargeValue,
              ),
            ),
            Text(
              context.l10n.locked,
              style: context.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
