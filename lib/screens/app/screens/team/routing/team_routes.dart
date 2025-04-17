import 'package:app/screens/app/screens/team/screens/groups/routing/groups_routes.dart';
import 'package:auto_route/auto_route.dart';

abstract class TeamRoutes{
  static List<AutoRoute> get() => [
    ...GroupsRoutes.get(),
  ];
}
