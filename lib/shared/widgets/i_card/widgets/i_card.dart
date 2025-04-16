import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/shared/widgets/i_card/models/i_card_item.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class ICard extends StatelessWidget {
  const ICard({required this.children, super.key});

  final List<ICardItem> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: mediumPadding,
      decoration:
      BoxDecoration(color: context.container, borderRadius: mediumRadius),
      child: Column(
        spacing: xLargeValue,
        children: children.map((child) {
          return Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (child.label != null)
                    Text(
                      child.label!,
                      style: context.titleMedium,
                    ),
                  Text(
                    child.value,
                    style: context.bodyMedium,
                  ),
                ],
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
