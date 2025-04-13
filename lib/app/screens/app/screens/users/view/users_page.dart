import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Users")),
    );
  }
}
