import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget iAppBar({
  required BuildContext context,
  String? title,
  bool showBackButton = true,
  List<Widget>? actions,
  VoidCallback? backButtonAction,
}) =>
    AppBar(
      title: title != null ? Text(title) : null,
      leading: showBackButton
          ? IconButton(
        onPressed: backButtonAction ?? context.maybePop,
        icon: const Icon(Icons.chevron_left),
      )
          : null,
      actions: actions,
    );
