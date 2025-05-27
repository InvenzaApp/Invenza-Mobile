import 'package:app/extensions/text_extension.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IShowAuthorWidget extends StatelessWidget {
  const IShowAuthorWidget({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: smallValue,
      children: [
        Icon(
          Icons.person_outline,
          size: xLargeValue,
        ),
        Text(
          user.title,
          style: context.bodyMedium,
        ),
      ],
    );
  }
}
