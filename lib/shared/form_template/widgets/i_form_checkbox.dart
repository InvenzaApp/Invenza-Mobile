import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/shared/form_template/i_form_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class IFormCheckbox extends IFormStatefulWidget {
  const IFormCheckbox({
    required this.name,
    required this.title,
    this.subtitle,
    this.initialValue,
    super.key,
  });

  final String name;
  final String title;
  final String? subtitle;
  final bool? initialValue;

  @override
  State<StatefulWidget> createState() => _IFormCheckboxState();
}

class _IFormCheckboxState extends State<IFormCheckbox> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    if(widget.initialValue != null){
      setState(() {
        isChecked = widget.initialValue!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckbox(
      initialValue: widget.initialValue,
      decoration: InputDecoration(
        fillColor: isChecked ? context.primaryContainer : context.container,
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          gapPadding: 0,
        ),
      ),
      name: widget.name,
      title: Text(
        widget.title,
        style: context.titleSmall,
      ),
      subtitle: widget.subtitle == null
          ? null
          : Text(
        widget.subtitle!,
        style: context.bodyMedium,
      ),
      onChanged: (value) {
        setState(() {
          isChecked = !isChecked;
        });
      },
    );
  }
}
