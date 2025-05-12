import 'package:app/extensions/color_extension.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class CommentsFaker extends StatelessWidget {
  const CommentsFaker({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: mediumPadding,
          child: Container(
            padding: smallPadding,
            decoration: BoxDecoration(
              color: context.container,
              borderRadius: mediumRadius,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        spacing: smallValue,
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: largeValue,
                          ),
                          const Text('CCCCCCCCCC'),
                        ],
                      ),
                      Row(
                        spacing: smallValue,
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            size: largeValue,
                          ),
                          const Text(
                            'CCCC CCCCCCCC',
                          ),
                        ],
                      ),
                      const Text(
                        'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC '
                            'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC',
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
