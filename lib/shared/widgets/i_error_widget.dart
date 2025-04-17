import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IErrorWidget extends StatelessWidget {
  const IErrorWidget({
    this.title,
    this.subtitle,
    this.icon,
    this.showSubtitle = true,
    this.onPressed,
    super.key,
  });

  final String? title;
  final String? subtitle;
  final IconData? icon;
  final bool showSubtitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: largePadding,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(largeValue),
          child: Ink(
            padding: largePadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon ?? Icons.error_outline,
                      size: 64,
                      color: context.primary,
                    ),
                    SizedBox(
                      height: largeValue,
                    ),
                    Text(
                      title ?? context.l10n.error_title,
                      style: context.titleMedium.copyWith(
                        color: context.onSurfaceVariant,
                      ),
                    ),
                    if (showSubtitle)
                      Text(
                        subtitle ?? context.l10n.error_subtitle,
                        style: context.bodyMedium.copyWith(
                          color: context.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
