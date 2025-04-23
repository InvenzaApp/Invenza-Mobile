import 'package:app/extensions/color_extension.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class ILogoWidget extends StatelessWidget {
  const ILogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: xLargePadding,
          child: Image.asset(
            'assets/images/black_logo.png',
            width: constraints.maxWidth * 0.8,
            color: context.isDarkMode ? Colors.white : Colors.black,
            colorBlendMode: BlendMode.srcIn,
          ),
        );
      },
    );
  }
}
