import 'package:app/enums/task_status.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class IFormTaskStatusModal extends StatelessWidget {
  const IFormTaskStatusModal({required this.selectedStatus, super.key});

  final TaskStatus selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: TaskStatus.values.map((item) {
        final isSelected = selectedStatus == item;
        return InkWell(
          onTap: () => context.maybePop(item),
          child: Ink(
            padding: mediumPadding,
            decoration: BoxDecoration(
              color: isSelected ? context.primaryContainer : null,
              border: Border(
                top: BorderSide(
                  color: isSelected ? context.primary : Colors.transparent,
                ),
                bottom: BorderSide(
                  color: isSelected ? context.primary : Colors.transparent,
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  item.getName(context),
                  style: context.bodyMedium,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
