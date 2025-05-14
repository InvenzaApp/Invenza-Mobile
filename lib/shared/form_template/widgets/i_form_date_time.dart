import 'package:app/extensions/text_extension.dart';
import 'package:app/shared/form_template/models/i_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class IFormDateTime extends IFormStatelessWidget {
  const IFormDateTime({
    required this.name,
    this.label,
    this.placeholder,
    this.initialValue,
    this.valueTransformer,
    this.validators = const [],
    super.key,
  });

  final String name;
  final String? label;
  final String? placeholder;
  final DateTime? initialValue;
  final dynamic Function(DateTime?)? valueTransformer;
  final List<FormFieldValidator<DateTime>> validators;

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
          name: name,
          decoration: InputDecoration(
            hintText: placeholder,
          ),
          initialValue: initialValue,
          valueTransformer: valueTransformer,
          validator: FormBuilderValidators.compose(validators),
        ),
      ],
    );
  }
}
