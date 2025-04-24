import 'package:app/shared/widgets/i_card/i_card.dart';
import 'package:app/shared/widgets/i_faker_list_widget.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IFakerShowWidget extends StatelessWidget {
  const IFakerShowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: mediumPadding,
      child: Column(
        spacing: mediumValue,
        children: [
          const ICard(
            children: [
              ICardItem(
                label: 'CCCCCCCCCC',
                value: 'CCCCCCCCCCCCCCCCCC',
              ),
              ICardItem(
                label: 'CCCCCCCCCC',
                value: 'CCCCCCCCCCCCCCCCCC',
              ),
              ICardItem(
                label: 'CCCCCCCCCC',
                value: 'CCCCCCCCCCCCCCCCCC',
              ),
              ICardItem(
                label: 'CCCCCCCCCC',
                value: 'CCCCCCCCCCCCCCCCCC',
              ),
              ICardItem(
                label: 'CCCCCCCCCC',
                value: 'CCCCCCCCCCCCCCCCCC',
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const IFakerListWidget(),
                    SizedBox(height: mediumValue),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
