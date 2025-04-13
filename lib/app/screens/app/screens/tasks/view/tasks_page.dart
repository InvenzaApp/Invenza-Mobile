import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Tasks")),
    );
  }
}
