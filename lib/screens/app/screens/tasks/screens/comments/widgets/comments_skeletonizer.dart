import 'package:app/extensions/color_extension.dart';
import 'package:app/screens/app/screens/tasks/screens/comments/widgets/comments_faker.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CommentsSkeletonizer extends StatelessWidget {
  const CommentsSkeletonizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      containersColor: context.container,
      effect: ShimmerEffect(
        baseColor: context.containerHighest,
        highlightColor: context.containerLow,
      ),
      child: const CommentsFaker(),
    );
  }
}
