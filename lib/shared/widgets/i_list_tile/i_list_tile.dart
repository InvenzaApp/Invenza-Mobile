import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IListTile extends StatelessWidget {
  const IListTile({
    super.key,
    this.title,
    this.icon,
    this.onPressed,
  });

  final String? title;
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(mediumValue),
      child: Ink(
        padding: xLargePadding,
        decoration: BoxDecoration(
          color: context.container,
          borderRadius: mediumRadius,
        ),
        child: Row(
          spacing: mediumValue,
          children: [
            if (icon != null)
              Icon(
                icon,
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: context.bodyMedium,
                      softWrap: true,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
