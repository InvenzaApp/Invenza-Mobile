import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_loading_widget.dart';
import 'package:flutter/material.dart';

class IScaffoldLoadingWidget extends StatelessWidget {
  const IScaffoldLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: iAppBar(
        context: context,
      ),
      body: const ILoadingWidget(),
    );
  }
}
