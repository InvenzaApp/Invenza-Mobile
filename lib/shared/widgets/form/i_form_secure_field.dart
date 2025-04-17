import 'package:app/extensions/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class IFormSecureField extends StatelessWidget {
  const IFormSecureField({
    required this.name,
    this.label,
    this.placeholder,
    this.actionNext = true,
    this.validators = const [],
    super.key,
  });

  final String name;
  final String? label;
  final String? placeholder;
  final bool actionNext;
  final List<FormFieldValidator<String>> validators;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: context.bodyMedium,
          ),
        FormBuilderTextField(
          name: name,
          decoration: InputDecoration(
            hintText: placeholder,
          ),
          textInputAction:
              actionNext ? TextInputAction.next : TextInputAction.done,
          obscureText: true,
          validator: FormBuilderValidators.compose(validators),
        ),
      ],
    );
  }
}
