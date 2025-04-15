import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ISecureField extends StatelessWidget {
  const ISecureField({
    required this.name,
    required this.hint,
    this.actionNext = true,
    this.validators = const [],
    super.key,
  });

  final String name;
  final String hint;
  final bool actionNext;
  final List<FormFieldValidator<String>> validators;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      decoration: InputDecoration(
        hintText: hint,
      ),
      textInputAction: actionNext ? TextInputAction.next : TextInputAction.done,
      obscureText: true,
      validator: FormBuilderValidators.compose(validators),
    );
  }
}
