import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: iAppBar(
        context: context,
        title: 'Tasks',
        showBackButton: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushRoute(const TasksFormRoute()),
        child: Icon(Icons.add),
      ),
      body: Column(),
    );
  }
}
