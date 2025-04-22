import 'package:app/variables.dart';
import 'package:flutter/material.dart';

class IFakerFormWidget extends StatelessWidget {
  const IFakerFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(mediumValue),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CCCCCCCCCCCCCC',
          ),
          TextField(),
        ],
      ),
    );
  }
}
