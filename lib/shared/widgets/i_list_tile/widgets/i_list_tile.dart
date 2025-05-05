import 'package:app/shared/widgets/i_list_tile/models/i_list_tile_item.dart';
import 'package:app/shared/widgets/i_list_tile/widgets/i_list_tile_item_widget.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IListTile extends StatelessWidget {
  const IListTile({required this.children, super.key});

  final List<IListTileItem> children;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: children.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IListTileItemWidget(
              child: children[index],
              listLength: children.length,
              index: index,
            ),
            if(index != children.length - 1)
              SizedBox(height: smallValue),
          ],
        );
      },
    );
  }
}
