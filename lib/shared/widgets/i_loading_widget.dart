import 'package:app/extensions/color_extension.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class ILoadingWidget extends StatelessWidget {
  const ILoadingWidget({super.key});

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
