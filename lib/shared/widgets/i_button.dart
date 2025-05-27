import 'package:app/extensions/color_extension.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IButton extends StatelessWidget {
  const IButton({
    required this.label,
    required this.onPressed,
    this.fullWidth = true,
    this.leadingIcon,
    this.isPending = false,
    this.enabled = true,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final bool fullWidth;
  final IconData? leadingIcon;
  final bool isPending;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            if(!enabled) return context.onSurfaceVariant;
            return context.primary;
          },
        ),
      ),
      onPressed: () {
        if(!enabled) return;
        if (!isPending) {
          onPressed();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
        children: [
          if (isPending)
            Transform.scale(
              scale: 0.7,
              child: CircularProgressIndicator(
                color: context.onPrimary,
              ),
            )
          else ...[
            if (leadingIcon != null)...[
              Icon(
                leadingIcon,
              ),
              SizedBox(width: smallValue),
            ],
            Text(
              label,
            ),
          ],
        ],
      ),
    );
  }
}
