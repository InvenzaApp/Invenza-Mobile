import 'package:flutter/material.dart';

class IListTile {
  const IListTile({
    this.title,
    this.icon,
    this.onPressed,
  });

  final String? title;
  final IconData? icon;
  final VoidCallback? onPressed;
}
