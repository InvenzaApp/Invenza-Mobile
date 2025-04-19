import 'package:app/extensions/color_extension.dart';
import 'package:app/shared/form_template/models/i_form_widget.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IFormLoadingWidget extends IFormWidget {
  const IFormLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: largePadding,
        decoration: BoxDecoration(
          color: context.primary,
          borderRadius: largeRadius,
        ),
        child: CircularProgressIndicator(
          color: context.onPrimary,
        ),
      ),
    );
  }
}
