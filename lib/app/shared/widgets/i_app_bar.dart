import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget iAppBar({
  required BuildContext context,
  required String title,
  bool showBackButton = true,
}) =>
    AppBar(
      title: Text(title),
      leading: showBackButton
          ? IconButton(
        onPressed: context.maybePop,
        icon: const Icon(Icons.chevron_left),
      )
          : null,
    );
