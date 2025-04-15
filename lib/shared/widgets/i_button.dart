import 'package:app/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class IButton extends StatelessWidget {
  const IButton({
    required this.label,
    required this.onPressed,
    this.fullWidth = true,
    this.leadingIcon,
    this.isPending = false,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final bool fullWidth;
  final IconData? leadingIcon;
  final bool isPending;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
        children: [
          if(isPending)
            Transform.scale(
              scale: 0.7,
              child: CircularProgressIndicator(
                color: context.onPrimary,
              ),
            )
          else
            ...[
              if(leadingIcon != null)
                Icon(
                  leadingIcon,
                ),
              Text(
                label,
              ),
            ],
        ],
      ),
    );
  }
}
