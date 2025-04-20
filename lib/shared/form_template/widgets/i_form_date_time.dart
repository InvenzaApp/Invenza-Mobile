import 'package:app/extensions/text_extension.dart';
import 'package:app/shared/form_template/models/i_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class IFormDateTime extends IFormWidget {
  const IFormDateTime({
    required this.name,
    this.label,
    this.placeholder,
    this.initialValue,
    this.valueTransformer,
    super.key,
  });

  final String name;
  final String? label;
  final String? placeholder;
  final DateTime? initialValue;
  final dynamic Function(DateTime?)? valueTransformer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(label != null)
          Text(
            label!,
            style: context.bodyMedium,
          ),
        FormBuilderDateTimePicker(
          name: 'deadline',
          decoration: InputDecoration(
            hintText: placeholder,
          ),
          initialValue: initialValue,
          valueTransformer: valueTransformer,
        ),
      ],
    );
  }
}
