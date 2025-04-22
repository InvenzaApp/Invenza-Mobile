import 'package:app/extensions/color_extension.dart';
import 'package:app/shared/widgets/i_faker_list_widget.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class IListSkeletonizer extends StatelessWidget {
  const IListSkeletonizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: mediumPadding,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Skeletonizer(
            containersColor: context.containerHighest,
            effect: ShimmerEffect(
              baseColor: context.containerHighest,
              highlightColor: context.containerLow,
            ),
            child: Column(
              children: [
                const IFakerListWidget(),
                SizedBox(height: mediumValue),
              ],
            ),
          );
        },
      ),
    );
  }
}
