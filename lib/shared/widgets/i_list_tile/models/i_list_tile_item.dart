import 'package:flutter/material.dart';

class IListTileItem {
  const IListTileItem({
    this.title,
    this.icon,
    this.onPressed,
  });

  final String? title;
  final IconData? icon;
  final VoidCallback? onPressed;
}
