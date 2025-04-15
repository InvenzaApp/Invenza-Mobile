import 'package:app/extensions/app_localizations.dart';
import 'package:flutter/material.dart';

extension AlertExtension on BuildContext {
  Future<void> showAlert(String message) async {
    await showDialog<void>(
      context: this,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.notification),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.ok),
            ),
          ],
        );
      },
    );
  }
}
