import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IFakerListWidget extends StatelessWidget {
  const IFakerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(mediumValue),
      child: Ink(
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
                Icons.task,
                color: context.onPrimary,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CCCCCCCCCCC',
                    style: context.titleMedium,
                  ),
                  Text(
                    'CCCCCCCCCCCCCCCCCCCCCC',
                    style: context.titleMedium,
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
