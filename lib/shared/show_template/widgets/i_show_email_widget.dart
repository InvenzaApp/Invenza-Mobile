import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:flutter/material.dart';

class IShowEmailWidget extends StatelessWidget {
  const IShowEmailWidget({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.bodyMedium.copyWith(color: context.onSurfaceVariant),
    );
  }
}
