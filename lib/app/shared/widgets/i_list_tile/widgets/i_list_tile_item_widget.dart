import 'package:app/app/extensions/color_extension.dart';
import 'package:app/app/extensions/text_extension.dart';
import 'package:app/app/shared/widgets/i_list_tile/helpers/i_list_tile_item_widget_border_radius.dart';
import 'package:app/app/shared/widgets/i_list_tile/models/i_list_tile_item.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IListTileItemWidget extends StatelessWidget {
  const IListTileItemWidget({
    required this.child,
    required this.listLength,
    required this.index,
    super.key,
  });

  final IListTileItem child;
  final int index;
  final int listLength;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: child.onPressed,
      borderRadius: getInkWellBorderRadius(index, listLength),
      child: Ink(
        padding: largePadding,
        decoration: BoxDecoration(
          color: context.container,
          borderRadius: getInkBorderRadius(index, listLength),
        ),
        child: Row(
          spacing: largeValue,
          children: [
            if (child.icon != null)
              Icon(
                child.icon,
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (child.title != null)
                  Text(
                    child.title!,
                    style: context.titleMedium,
                  ),
                if (child.subtitle != null)
                  Text(
                    child.subtitle!,
                    style: context.bodyMedium,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
