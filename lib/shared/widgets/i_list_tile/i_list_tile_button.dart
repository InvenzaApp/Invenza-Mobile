import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/shared/widgets/i_list_tile/models/i_list_tile.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IListTileButton extends StatelessWidget {
  const IListTileButton({
    required this.child,
    required this.length,
    required this.index,
    super.key,
  });

  final IListTile child;
  final int length;
  final int index;

  BorderRadius _getBorderRadius() {
    if(length == 1){
      return BorderRadius.circular(mediumValue);
    }

    if(index == 0){
      return BorderRadius.only(
        topLeft: Radius.circular(mediumValue),
        topRight: Radius.circular(mediumValue),
      );
    }

    if(index == (length - 1)){
      return BorderRadius.only(
        bottomLeft: Radius.circular(mediumValue),
        bottomRight: Radius.circular(mediumValue),
      );
    }

    return BorderRadius.zero;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: child.onPressed,
      borderRadius: _getBorderRadius(),
      child: Ink(
        padding: xLargePadding,
        decoration: BoxDecoration(
          color: context.container,
          borderRadius: _getBorderRadius(),
        ),
        child: Row(
          spacing: mediumValue,
          children: [
            if (child.icon != null)
              Icon(
                child.icon,
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (child.title != null)
                    Text(
                      child.title!,
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
