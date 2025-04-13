import 'package:flutter/material.dart';

class IListTileItem {
  const IListTileItem({
    this.title,
    this.subtitle,
    this.icon,
    this.onPressed,
  });

  final String? title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onPressed;
}
