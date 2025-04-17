import 'package:app/extensions/text_extension.dart';
import 'package:app/shared/widgets/form/i_form_checkbox_group/i_form_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class IFormCheckboxGroup<T> extends StatelessWidget {
  const IFormCheckboxGroup({
    required this.name,
    required this.options,
    this.label,
    this.initialValue,
    this.validators = const [],
    super.key,
  });

  final String name;
  final String? label;
  final List<IFormOption<T>> options;
  final List<T>? initialValue;
  final List<FormFieldValidator<List<dynamic>>> validators;

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
        FormBuilderCheckboxGroup<T>(
          name: name,
          orientation: OptionsOrientation.vertical,
          options: options.map((item) {
            return FormBuilderFieldOption<T>(
              value: item.value,
              child: Text(item.label),
            );
          }).toList(),
          initialValue: initialValue,
          validator: FormBuilderValidators.compose(validators),
        ),
      ],
    );
  }
}
