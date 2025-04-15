import 'package:app/extensions/app_localizations.dart';
import 'package:flutter/material.dart';

extension ConfirmExtension on BuildContext {
  Future<bool?> showConfirm(String message) async {
    return showDialog<bool>(
      context: this,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.notification),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.confirm),
            ),
          ],
        );
      },
    );
  }
}
