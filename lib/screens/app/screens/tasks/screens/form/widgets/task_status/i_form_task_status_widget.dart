import 'package:app/enums/task_status.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/screens/app/screens/tasks/screens/form/widgets/task_status/i_form_task_status_modal.dart';
import 'package:app/shared/form_template/i_form_template.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class IFormTaskStatusWidget extends IFormStatefulWidget {
  const IFormTaskStatusWidget({required this.status, super.key});

  final TaskStatus status;

  @override
  State<IFormTaskStatusWidget> createState() => _IFormTaskStatusWidgetState();
}

class _IFormTaskStatusWidgetState extends State<IFormTaskStatusWidget> {
  late TaskStatus taskStatus;

  @override
  void initState() {
    super.initState();
    taskStatus = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: 'status',
      initialValue: taskStatus.name,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.status,
              style: context.bodyMedium,
            ),
            InkWell(
              onTap: () async {
                final status = await showModalBottomSheet<TaskStatus>(
                  showDragHandle: true,
                  context: context,
                  builder: (context) {
                    return IFormTaskStatusModal(
                      selectedStatus: taskStatus,
                    );
                  },
                );

                if(status != null){
                  field.didChange(status.name);
                  setState(() {
                    taskStatus = status;
                  });
                }
              },
              borderRadius: BorderRadius.circular(smallValue),
              child: Ink(
                padding: mediumPadding,
                decoration: BoxDecoration(
                  color: context.primaryContainer,
                  borderRadius: smallRadius,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n.task_status,
                      style: context.bodyMedium,
                    ),
                    Text(
                      taskStatus.getName(context),
                      style: context.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
