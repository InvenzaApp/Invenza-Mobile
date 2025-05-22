import 'package:app/shared/widgets/i_list_tile/i_list_tile_button.dart';
import 'package:app/shared/widgets/i_list_tile/models/i_list_tile.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IListTileWidget extends StatelessWidget {
  const IListTileWidget({required this.children, super.key});

  final List<IListTile> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: xSmallValue,
        children: children.map((child) {
          final index = children.indexOf(child);

          return IListTileButton(
            child: child,
            index: index,
            length: children.length,
          );
        }).toList(),
      ),
    );
  }
}
