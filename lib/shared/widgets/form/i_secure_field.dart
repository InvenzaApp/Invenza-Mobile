import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ISecureField extends StatelessWidget {
  const ISecureField({
    required this.name,
    required this.hint,
    this.actionNext = true,
    super.key,
  });

  final String name;
  final String hint;
  final bool actionNext;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      decoration: InputDecoration(
        hintText: hint,
      ),
      textInputAction: actionNext ? TextInputAction.next : TextInputAction.done,
      obscureText: true,
    );
  }
}
