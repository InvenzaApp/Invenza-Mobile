import 'package:app/app/shared/widgets/i_app_bar.dart';
import 'package:app/app/shared/widgets/i_list_tile/i_list_tile.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: iAppBar(
        context: context,
        title: "Team",
        showBackButton: false,
      ),
      body: Padding(
        padding: largePadding,
        child: IListTile(
          children: [
            IListTileItem(
              title: "Users",
              subtitle: "Manage users in your company",
              icon: Icons.person,
              onPressed: (){},
            ),
            IListTileItem(
              title: "Teams",
              subtitle: "Manage teams in your company",
              icon: Icons.groups,
              onPressed: (){}
            ),
          ],
        ),
      ),
    );
  }
}






