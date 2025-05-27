import 'package:app/extensions/text_extension.dart';
import 'package:flutter/material.dart';

class IShowTitleWidget extends StatelessWidget {
  const IShowTitleWidget({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.titleLarge,
    );
  }
}
