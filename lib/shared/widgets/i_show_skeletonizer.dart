import 'package:app/extensions/color_extension.dart';
import 'package:app/shared/widgets/i_faker_show_widget.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class IShowSkeletonizer extends StatelessWidget {
  const IShowSkeletonizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      containersColor: context.containerHighest,
      effect: ShimmerEffect(
        baseColor: context.containerHighest,
        highlightColor: context.containerLow,
      ),
      child: const IFakerShowWidget(),
    );
  }
}
