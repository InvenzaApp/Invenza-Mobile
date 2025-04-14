import 'package:app/extensions/color_extension.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class ICheckbox<T> extends StatelessWidget {
  const ICheckbox({
    required this.title,
    required this.isChecked,
    required this.wantedValue,
    required this.onChange,
    this.unselectedIcon,
    super.key,
  });

  final String title;
  final bool isChecked;
  final T wantedValue;
  final void Function(T) onChange;
  final IconData? unselectedIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChange(wantedValue),
      borderRadius: BorderRadius.circular(mediumValue),
      child: Ink(
        decoration: BoxDecoration(
          color: isChecked ? context.primaryContainer : context.container,
          borderRadius: mediumRadius,
        ),
        child: Padding(
          padding: xLargePadding,
          child: Row(
            spacing: mediumValue,
            children: [
              Icon(
                isChecked
                    ? Icons.check_circle
                    : unselectedIcon ?? Icons.circle_outlined,
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
