import 'package:app/extensions/text_extension.dart';
import 'package:app/shared/form_template/models/i_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class IFormSecureField extends IFormStatefulWidget {
  const IFormSecureField({
    required this.name,
    this.label,
    this.placeholder,
    this.actionNext = true,
    this.validators = const [],
    this.showTogglePasswordVisibility = true,
    super.key,
  });

  final String name;
  final String? label;
  final String? placeholder;
  final bool actionNext;
  final List<FormFieldValidator<String>> validators;
  final bool showTogglePasswordVisibility;

  @override
  State<IFormSecureField> createState() => _IFormSecureFieldState();
}

class _IFormSecureFieldState extends State<IFormSecureField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: context.bodyMedium,
          ),
        FormBuilderTextField(
          name: widget.name,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            suffixIcon: widget.showTogglePasswordVisibility
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    icon:
                        Icon(obscure ? Icons.visibility : Icons.visibility_off),
                  )
                : null,
          ),
          textInputAction:
              widget.actionNext ? TextInputAction.next : TextInputAction.done,
          obscureText: obscure,
          validator: FormBuilderValidators.compose(widget.validators),
        ),
      ],
    );
  }
}
