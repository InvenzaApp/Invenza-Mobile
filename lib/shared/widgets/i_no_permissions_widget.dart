import 'package:app/extensions/app_localizations.dart';
import 'package:app/shared/widgets/i_error_widget.dart';
import 'package:flutter/material.dart';

class INoPermissionsWidget extends StatelessWidget {
  const INoPermissionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IErrorWidget(
      icon: Icons.shield_outlined,
      title: context.l10n.no_permissions_title,
      subtitle: context.l10n.no_permissions_subtitle,
    );
  }
}
