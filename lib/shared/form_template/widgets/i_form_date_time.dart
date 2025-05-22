import 'package:app/extensions/text_extension.dart';
import 'package:app/shared/form_template/models/i_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class IFormDateTime extends IFormStatefulWidget {
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
  State<StatefulWidget> createState() => _IFormDateTimeState();
}

class _IFormDateTimeState extends State<IFormDateTime> {
  bool showingDelete = false;

  final _formKey = GlobalKey<FormBuilderFieldState<dynamic, dynamic>>();

  @override
  void initState() {
    super.initState();

    if(widget.initialValue != null){
      setState(() {
        showingDelete = true;
      });
    }
  }

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
        FormBuilderDateTimePicker(
          key: _formKey,
          name: widget.name,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            suffixIcon: showingDelete
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _formKey.currentState?.didChange(null);
                        showingDelete = false;
                      });
                    },
                    icon: const Icon(Icons.close),
                  )
                : null,
          ),
          onChanged: (value) {
            if(value != null) {
              setState(() {
                showingDelete = true;
              });
            }
          },
          initialValue: widget.initialValue,
          valueTransformer: widget.valueTransformer,
          validator: FormBuilderValidators.compose(widget.validators),
        ),
      ],
    );
  }
}
