import 'package:app/extensions/color_extension.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_faker_form_widget.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class IFormSkeletonizer extends StatelessWidget {
  const IFormSkeletonizer({
    this.showAppBar = true,
    super.key,
  });

  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? iAppBar(
              context: context,
            )
          : null,
      body: Padding(
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
                  const IFakerFormWidget(),
                  SizedBox(height: mediumValue),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
