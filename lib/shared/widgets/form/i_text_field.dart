import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ITextField extends StatelessWidget {
  const ITextField({
    required this.name,
    required this.hint,
    this.actionNext = true,
    this.validators = const [],
    this.initialValue,
    super.key,
  });

  final String name;
  final String hint;
  final bool actionNext;
  final List<FormFieldValidator<String>> validators;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      initialValue: initialValue,
      decoration: InputDecoration(
        label: Text(hint),
      ),
      textInputAction: actionNext ? TextInputAction.next : TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose(validators),
    );
  }
}
